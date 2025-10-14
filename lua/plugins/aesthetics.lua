return {

	-- Colorscheme

	-- Gruvbox
	-- {
	-- 	"ellisonleao/gruvbox.nvim",
	-- 	priority = 1000,
	-- 	opts = {},
	-- 	config = function()
	-- 		require("gruvbox").setup({})
	-- 	end,
	-- },

	-- Leaf
	{
		"daschw/leaf.nvim",
		priority = 1000,
		opts = {},
		config = function()
			local c = require("leaf.colors").setup()

			require("leaf").setup({
				setfenvtheme = "dark",
				contrast = "medium",
				overrides = {
					Pmenu = { bg = c.bg0, fg = c.fg1 },
					PmenuSel = { bg = c.green0, fg = c.fg1, style = "bold" },
					PmenuSbar = { bg = "#006666" },
					PmenuSThumb = { bg = "#550055" },
				},
			})

			-- Trigger the colorscheme change
			vim.cmd.colorscheme("leaf")
		end,
	},

	-- Everforest
	-- {
	-- 	"neanias/everforest-nvim",
	-- 	priority = 1000,
	-- 	opts = {},
	-- 	config = function()
	-- 		require("everforest").setup({})
	-- 	end,
	-- },
}
