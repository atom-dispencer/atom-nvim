-- Configuration for the text-editor area, but not LSP
-- Includes snippets, completion and guides

return {


  -- TODO stuff
  -- 'Virtual text' indentation guides
  -- Currently just errors: utils.lua:428: attempt to call field 'iter' (a nil value)
  --{
  --  "lukas-reineke/indent-blankline.nvim",
  --  main = "ibl",
  --  opts = {}
  --}
  
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {}
  }
}
