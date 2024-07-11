-- Plugins for navigating around files and buffers and things...

return {


  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim"
    },
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({
              -- Can configure more stuff here, but I don't
            })
          }
        }
      })

      require("telescope").load_extension("ui-select")
    end
  },


  -- File manager
  {
    "stevearc/oil.nvim",
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup({
        keymaps = {
          ["<C-s>"] = false
        }
      })
    end
  }
}
