-- LSP configuration

--
-- Overall control for the Mason tools installed
-- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
--
local TOOLER_CONFIG = {
	ensure_installed = {
		-- MATLAB
		"matlab-language-server",
		-- Python
		"python-lsp-server",
		"black",
		-- Lua
		"lua-language-server",
		"stylua",
		"luacheck",
		-- Elixir
		"elixir-ls",
		-- Assembly
		"asm-lsp",
		"asmfmt",
	},

	-- Name integrations with the rest of the Mason ecosystem.
	-- I only want to use Mason package names for consistency, so disabled them
	integrations = {
		["mason-lspconfig"] = false,
		["mason-null-ls"] = false,
		["mason-nvim-dap"] = false,
	},
}

--
-- Mason's "ensure_installed" list.
--
local MASONLSP_CONFIG = {}

--
-- Configuration for Mason itself
--
local MASON_CONFIG = {
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "",
			package_uninstalled = "",
		},
	},
}

--
-- Configuration options for LSPs
--
local LSP_CONFIG = {
	matlab_ls = {
		settings = {
			MATLAB = {
				indexWorkspace = true,
				installPath = "",
				matlabConnectionTiming = "onStart",
				telemetry = false,
			},
		},
	},

	lua_ls = {
		-- Configure for Neodev
		settings = {
			Lua = {
				completion = {
					callSnippet = "Replace",
				},
			},
		},
	},

	pylsp = {},
	asm_lsp = {},
	elixirls = {},
}

--
-- Get all of the custom handlers for setting up LSP servers.
-- If all you need is a bunch of options, pass them into the LSP_CONFIG table instead of messing with this.
-- If you need to have a custom *behaviour* or different loading *flow*, add an entry here, but remember to add capabilities.
--
local get_custom_handlers = function()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

	return {

		-- Default handler
		function(server_name)
			local config = LSP_CONFIG[server_name]

			config["capabilities"] = capabilities
			-- config.on_attach = on_attach
			-- config.on_init = on_init
			require("lspconfig")[server_name].setup(config)
		end,
		-- Optionally, can add custom handlers here by key.
		-- See mason-lspconfig-dynamic-server-setup
	}
end

-- Return the composite version for Lazy
-- Loading order must be Mason > Mason LSP conf > Nvim LSP conf
return {

	-- Neovim's default LSP configurations
	{
		"neovim/nvim-lspconfig",

		dependencies = {
			{
				"williamboman/mason-lspconfig.nvim",
				config = function()
					-- Setup {} must be present, even if empty.
					require("mason-lspconfig").setup(MASONLSP_CONFIG)
					require("mason-lspconfig").setup_handlers(get_custom_handlers())
				end,

				dependencies = {
					{
						"williamboman/mason.nvim",
						config = function()
							require("mason").setup(MASON_CONFIG)
						end,
					},
					{
						"folke/neodev.nvim",
						config = function()
							require("neodev").setup({})
						end,
					},
				},
			},
		},
	},

	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-tool-installer").setup(TOOLER_CONFIG)
		end,
	},
}
