-- Plugins and configuration relating to the window and tabs and stuff
-- Different from aesthetics because that's all beauty, but this is
--  tab and command management.

return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 1000
      require("which-key").setup({
        -- Extra config goes here
        -- Can add custom mappings here
      })
    end
  },
  {
    "tjdevries/express_line.nvim",
    config = function()
      require("el").setup({})
    end
  }
}
