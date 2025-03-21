-- Plugins and configuration relating to the window and tabs and stuff
-- Different from aesthetics because that's all beauty, but this is
--  tab and command management.

return {

  
  -- Footer line 
  {
    "tjdevries/express_line.nvim",
    config = function()
      require("el").setup({})
    end
  },


  -- Tabline
  {
    'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function() vim.g.barbar_auto_setup = false end,
    config = function()
      require("barbar").setup({})
    end,
    version = '^1.0.0', -- optional: only update when a new 1.x version is released
  },
}
