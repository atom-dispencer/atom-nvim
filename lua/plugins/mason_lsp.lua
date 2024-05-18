-- LSP configuration

local mason_ensure_installed = {
  "matlab-language-server",
  "python-lsp-server",
  "lua-language-server",
  "stylua",
  "luacheck",
  "black",
}

local lsp_configurations = {
  matlab_ls = {
    settings = {
      MATLAB = {
        indexWorkspace = true,
        installPath = '',
        matlabConnectionTiming = 'onStart',
        telemetry = false,
      }
    }
  },

  lua_ls = {
    -- Configure for Neodev
    settings = {
      Lua = {
        completion = {
          callSnippet = "Replace"
        }
      }
    }
  },

  pylsp = {},
}


-- mason
local configure_mason = function()
  require("mason").setup({
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "",
        package_uninstalled = ""
      }
    },

    ensure_installed = mason_ensure_installed
  })
end


-- mason_lspconfig
local configure_mason_lspconfig = function()
  -- Setup {} must be present, even if empty.
  require("mason-lspconfig").setup({})
end


-- nvim_lspconfig
--
-- For each LSP server we must:
--   - Make sure it's installed
--   - Set up its attachment and capabilities
--   - Configure/Set it up
local configure_nvim_lspconfig = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

  local lspconfig = require("lspconfig")

  for server, config in pairs(lsp_configurations) do
    config["capabilities"] = capabilities
    -- config.on_attach = on_attach
    -- config.on_init = on_init
    lspconfig[server].setup(config)
  end
end


-- Must be BEFORE lspconfig
local configure_neodev = function()
  require("neodev").setup({})
end


-- Return the composite version for Lazy
-- Loading order must be Mason > Mason LSP conf > Nvim LSP conf
return {

  -- Neovim's default LSP configurations
  {
    "neovim/nvim-lspconfig",
    config = configure_nvim_lspconfig,

    dependencies = {
      {
        "williamboman/mason-lspconfig.nvim",
        config = configure_mason_lspconfig,

        dependencies = {
          "williamboman/mason.nvim",
          config = configure_mason,
        }
      },

      {
        "folke/neodev.nvim",
        config = configure_neodev
      },
    }
  },
}
