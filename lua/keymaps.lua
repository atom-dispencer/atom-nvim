local map = vim.keymap.set


-- Misc
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "config", ":e ~/AppData/Local/nvim/")
map("n", "<C-s>", ":update<cr>")


-- Telescope
local telescope = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescope.find_files, {})
vim.keymap.set('n', '<leader>fg', telescope.live_grep, {})
vim.keymap.set('n', '<leader>fb', telescope.buffers, {})
vim.keymap.set('n', '<leader>fh', telescope.help_tags, {})


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
