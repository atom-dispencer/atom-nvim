require "nvchad.mappings"

-- add yours here

print("atom-nvim: mappings")

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "config", ":e ~/AppData/Local/nvim/")

map("n", "<m-h>", "<c-w>5<")
map("n", "<m-j>", "<c-w>+")
map("n", "<m-k>", "<c-w>-")
map("n", "<m-l>", "<c-w>5>")

map("n", "<leader>ra", function()
  vim.lsp.buf.rename()
end)

map("n", "<C-F>", function()
  require("conform").format()
end)

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
