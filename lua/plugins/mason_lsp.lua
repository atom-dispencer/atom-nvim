local atom = require("../atom-nvim")
local languages = require("../languages")

--
-- Overall control for the Mason tools installed
-- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
--
local TOOLER_CONFIG = {
	ensure_installed = languages.MasonEnsureInstalled,

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
local MASON_LSP_CONFIG = languages.MasonLspConfig
local NVIM_LSP_CONFIG = languages.NvimLspConfig

--
-- Get all of the custom handlers for setting up LSP servers.
-- If all you need is a bunch of options, pass them into the LSP_CONFIG table instead of messing with this.
-- If you need to have a custom *behaviour* or different loading *flow*, add an entry here, but remember to add capabilities.
--
local get_mason_custom_handlers = function()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities())

	-- Border for <S-k> information box
	local border = {
		{ "╭", "FloatBorder" },
		{ "─", "FloatBorder" },
		{ "╮", "FloatBorder" },
		{ "│", "FloatBorder" },
		{ "╯", "FloatBorder" },
		{ "─", "FloatBorder" },
		{ "╰", "FloatBorder" },
		{ "│", "FloatBorder" },
	}

	local other_handlers = {
		["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
		["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
	}

	return {

		-- Default handler
		function(server_name)
			local extra_config = MASON_LSP_CONFIG[server_name]
			atom.log("Running custom Mason LSPConfig handler for " .. server_name)

			if extra_config == nil then
				atom.log("Nil LSP config entry for " .. server_name)
				atom.log(" > Make sure its installed AND configured.")
				atom.log(" > If this is the first time, restart Neovim as MasonToolsInstaller may clean the rogue LSP")
				return
			end

			extra_config["capabilities"] = capabilities
			-- config.on_attach = on_attach
			-- config.on_init = on_init
			require("lspconfig")[server_name].setup({ config = extra_config, handlers = other_handlers })
		end,
		-- Optionally, can add custom handlers here by key.
		-- See mason-lspconfig-dynamic-server-setup
	}
end

local nvim_lspconfig_setup = function()
	atom.log("Starting Neovim LSPConfig setup...")
	local lspconfig = require("lspconfig")

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities())

	for server_name, config in pairs(NVIM_LSP_CONFIG) do
		atom.log("Setting up Neovim LSPConfig for " .. server_name)
		config["capabilities"] = capabilities
		lspconfig[server_name].setup(config)
	end
end

-- Return the composite version for Lazy
-- Loading order must be Mason > Mason LSP conf > Nvim LSP conf
return {

	-- Neovim's default LSP configurations
	{
		"neovim/nvim-lspconfig",
		config = function()
			nvim_lspconfig_setup()
		end,

		dependencies = {
			{
				"williamboman/mason-lspconfig.nvim",
				config = function()
					-- Setup {} must be present, even if empty.
					require("mason-lspconfig").setup(MASONLSP_CONFIG)
					require("mason-lspconfig").setup_handlers(get_mason_custom_handlers())
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
			vim.fn.execute("MasonToolsClean", true)
		end,
	},
}
