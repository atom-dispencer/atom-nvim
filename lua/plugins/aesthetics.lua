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
			require("leaf").setup({})
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
