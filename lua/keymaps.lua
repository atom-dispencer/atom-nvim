local map = vim.keymap.set

-- Misc
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>", { desc = "lol." })
map("n", "config", "<CMD>Oil ~/AppData/Local/nvim/<CR>", { desc = "Open Neovim's configuration directory." })
map("n", "<C-s>", "<CMD>update<CR>", { desc = "Save (Update) the current buffer.", silent = true })
map("n", "<LEADER>s", "<CMD>split<CR>", { desc = "Open a horizontal split", silent = true })
map("n", "<LEADER>v", "<CMD>vsplit<CR>", { desc = "Open a vertical split", silent = true })

-- Pressing enter does the oppostite of [J]oin.
-- The extra stuff is to make it behave differently at the end of the line.
-- At the end of the line, just adds a new line, otherwise takes remainder of line with it.
map("n", "<CR>", function()
	local keys = ""

	if vim.fn.col(".") == vim.fn.col("$") - 1 then
		keys = "o<ESC>"
	else
		keys = "i<CR><ESC>"
	end

	keys = vim.api.nvim_replace_termcodes(keys, false, false, true)
	vim.fn.feedkeys(keys)
end, { desc = "Split line" })

-- Telescope
local telescope = require("telescope.builtin")
map("n", "<leader>ff", telescope.find_files, { desc = "Telescope: Find files." })
map("n", "<leader>fz", telescope.current_buffer_fuzzy_find, { desc = "Telescope: Fuzzy find in this buffer." })
map("n", "<leader>fg", telescope.live_grep, { desc = "Telescope: Live grep." })
map("n", "<leader>fb", telescope.buffers, { desc = "Telescope: Find buffer." })
map("n", "<leader>fh", telescope.help_tags, { desc = "Telescope: Search help tags." })

-- Oil
map("n", "<C-n>", "<CMD>Oil<CR>", { desc = "Open Oil at this buffer." })
-- C-c is the default closing map

-- Barbar
-- Note: Unused keybinds include:
--   - Go to buffer by number 1-9
--   - Close buffers on left/right, un/pinned, not/current
--   - Sort buffers by number, directory, language, name, etc.

map("n", "<Tab>", "<CMD>BufferNext<CR>", { desc = "Barbar: Next buffer.", noremap = true, silent = true })
map("n", "<S-Tab>", "<CMD>BufferPrevious<CR>", { desc = "Barbar: Previous buffer.", noremap = true, silent = true })
map("n", "<A->>", "<CMD>BufferMoveNext<CR>", { desc = "Barbar: Shuffle buffer right.", noremap = true, silent = true })
map(
	"n",
	"<A-<>",
	"<CMD>BufferMovePrevious<CR>",
	{ desc = "Barbar: Shuffle buffer left.", noremap = true, silent = true }
)
map("n", "<A-p>", "<CMD>BufferPin<CR>", { desc = "Barbar: Pin buffer.", noremap = true, silent = true })
map("n", "<LEADER>x", "<CMD>BufferClose<CR>", { desc = "Barbar: Close buffer.", noremap = true, silent = true })
map("n", "<C-p>", "<CMD>BufferPick<CR>", { desc = "Barbar: Magic buffer picker.", noremap = true, silent = true })

-- Splits
map("n", "<m-h>", "<c-w>5<", { desc = "Resize pane: 5<" })
map("n", "<m-j>", "<c-w>+", { desc = "Resize pane: +" })
map("n", "<m-k>", "<c-w>-", { desc = "Resize pane: -" })
map("n", "<m-l>", "<c-w>5>", { desc = "Resize pane: 5>" })

-- LSP
map("n", "gd", require("telescope.builtin").lsp_definitions, { desc = "[G]oto [D]efinition" })
map("n", "gD", vim.lsp.buf.declaration, { desc = "[G]oto [D]eclaration" })
map("n", "gr", require("telescope.builtin").lsp_references, { desc = "[G]oto [R]eferences" })
map("n", "gI", require("telescope.builtin").lsp_implementations, { desc = "[G]oto [I]mplementation" })
map("n", "<leader>D", require("telescope.builtin").lsp_type_definitions, { desc = "Type [D]efinition" })
map("n", "<leader>ds", require("telescope.builtin").lsp_document_symbols, { desc = "[D]ocument [S]ymbols" })
map("n", "<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, { desc = "[W]orkspace [S]ymbols" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[R]e[n]ame" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })

-- Formatting
map("n", "<C-F>", function()
	require("conform").format()
end, { desc = "Reformat buffer" })
