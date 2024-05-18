-- Configuration for the text-editor area, but not LSP
-- Includes snippets, completion and guides

return {


  -- 'Virtual text' indentation guides
  --  Currently just errors: utils.lua:428: attempt to call field 'iter' (a nil value)
  {
    enabled = false,
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {}
  },
  

  -- INFO Highlight comments like this!
  {
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      signs = false,
    }
  },


  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          -- Nvim native
          "vim", "vimdoc", "lua", 
          -- Markup & comments
          "comment", "yaml", "markdown", "json", "xml",
          -- Languages
          "python", "java"
        },

        -- Do/not install synchronously
        sync_install = false,

        highlight = { enable = true },
        indent = { enable = true },
      })
    end
  }
}
