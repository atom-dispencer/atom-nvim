local map = vim.keymap.set


-- Misc
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "config", "<CMD>Oil ~/AppData/Local/nvim/<CR>")
map("n", "<C-s>", "<CMD>update<CR>", { desc = "Save (Update) the current buffer.", silent = true })


-- Telescope
local telescope = require('telescope.builtin')
map('n', '<leader>ff', telescope.find_files, {})
map('n', '<leader>fg', telescope.live_grep, {})
map('n', '<leader>fb', telescope.buffers, {})
map('n', '<leader>fh', telescope.help_tags, {})


-- Oil
map("n", "<C-n>", "<CMD>Oil<CR>")
-- C-c is the default closing map


-- Splits
map("n", "<m-h>", "<c-w>5<")
map("n", "<m-j>", "<c-w>+")
map("n", "<m-k>", "<c-w>-")
map("n", "<m-l>", "<c-w>5>")


-- LSP
map("n", "<leader>ra", function()
  vim.lsp.buf.rename()
end)

map("n", "<C-F>", function()
  require("conform").format()
end)
