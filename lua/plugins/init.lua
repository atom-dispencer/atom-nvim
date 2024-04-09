return {

  -- https://github.com/stevearc/conform.nvim
  {
    "stevearc/conform.nvim",

    formatters_by_ft = {
      java = {
        "google_java_format"
      },

      -- Use the "*" filetype to run formatters on all filetypes.
      ["*"] = { "codespell" },
      -- Use the "_" filetype to run formatters on filetypes that don't have other formatters configured.
      ["_"] = { "trim_whitespace" },
    },
    
    format_on_save = {
      lsp_fallback = true,
      timeout_ms = 500,
    },
  },

  -- These are some examples, uncomment them if you want to see them work!
   {
     "neovim/nvim-lspconfig",
     config = function()
       require("nvchad.configs.lspconfig").defaults()
       require "configs.lspconfig"
     end,
   },

   {
   	"williamboman/mason.nvim",
   	opts = {
   		ensure_installed = {
   			"lua-language-server", "stylua", "luacheck",
        "matlab-language-server",
        "jdtls", "java-test", "java-debug-adapter", "google-java-format"
   		},
   	},
   },

   {
   	"nvim-treesitter/nvim-treesitter",
   	opts = {
   		ensure_installed = {
   			"vim", "lua", "vimdoc",
        "java"
--        "html", "css"
   		},
   	},
   },

  {
    "mfussenegger/nvim-jdtls",
  }
}
