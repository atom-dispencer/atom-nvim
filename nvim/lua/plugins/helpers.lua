-- Miscellaneous helper plugins

return {

	-- Keybinds help
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 1000
			require("which-key").setup({
				-- Can add custom mappings here
			})
		end,
	},

	-- Markdown live preview
	-- Idk where else to put this?
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = "markdown",
		build = "cd app && npm install && npm update",
		init = function()
			-- vim.g.mkdp_auto_start = 1
			-- vim.g.mkdp_auto_close = 1
			-- vim.g.mkdp_refresh_slow = 0
			-- vim.g.mkdp_command_for_global = 0
			-- vim.g.mkdp_open_to_the_world = 0
			-- vim.g.mkdp_open_ip = ""
			-- vim.g.mkdp_browser = "explorer.exe"
			-- vim.g.mkdp_echo_preview_url = 1
			-- vim.g.mkdp_browserfunc = ""
			-- vim.g.mkdp_theme = "dark"
			-- vim.g.mkdp_filetypes = { "markdown" }
			-- vim.g.mkdp_page_title = "${name}.md"
			-- vim.g.mkdp_preview_options = {
			-- 	disable_sync_scroll = 0,
			--  disable_filename = 1,
			-- }
		end,
	},
}
