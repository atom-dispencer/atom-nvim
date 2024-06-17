-- Text formatting. Enough said.

return {

	-- 'Virtual text' indentation guides
	--  Currently just errors: utils.lua:428: attempt to call field 'iter' (a nil value)
	{
		enabled = false,
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
	},

	-- Conform formatter engine
	{
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup({

				format_on_save = {
					timeout_ms = 5000,
					lsp_fallback = true,
				},

				-- Formatters configured per file-type
				formatters_by_ft = {
					lua = { "stylua" },
					python = { "isort", "black" },
					elixir = { "mix" }, -- Uses the built-in 'mix format' task (I think ElixirLS expands on that task as well)
				},
			})
		end,
	},
}
