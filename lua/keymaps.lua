local map = vim.keymap.set

--
--
-- Terminal
--
--
local floaterminal = require("floaterminal")
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Return to normal mode from terminal mode" })
map("n", "<C-x>", floaterminal.toggle_terminal, { desc = "Toggle a floating terminal window" })

--
--
-- Misc (commands, saving, config)
--
--
local config_dir = vim.fn.stdpath("config")
map("n", "config", "<CMD>Oil " .. config_dir .. "/<CR>", { desc = "Open Neovim's configuration directory." })
map("n", "<C-s>", "<CMD>update<CR>", { desc = "Save (Update) the current buffer.", silent = true })

--
--
-- Telescope
--
--
local telescope = require("telescope.builtin")
map("n", "<leader>ff", telescope.find_files, { desc = "Telescope: Find files." })
map("n", "<leader>fz", telescope.current_buffer_fuzzy_find, { desc = "Telescope: Fuzzy find in this buffer." })
map("n", "<leader>fg", telescope.live_grep, { desc = "Telescope: Live grep." })
map("n", "<leader>fb", telescope.buffers, { desc = "Telescope: Find buffer." })
map("n", "<leader>fh", telescope.help_tags, { desc = "Telescope: Search help tags." })

--
--
-- Oil
--
--
map("n", "<C-n>", "<CMD>Oil<CR>", { desc = "Open Oil at this buffer." })
-- C-c is the default closing map

--
--
-- Barbar
--
--

-- Note: Unused keybinds include:
--   - Go to buffer by number 1-9
--   - Close buffers on left/right, un/pinned, not/current
--   - Sort buffers by number, directory, language, name, etc.

map("n", "<Tab>", "<CMD>BufferNext<CR>", { desc = "Barbar: Next buffer.", noremap = true, silent = true })
map("n", "<S-Tab>", "<CMD>BufferPrevious<CR>", { desc = "Barbar: Previous buffer.", noremap = true, silent = true })
-- map("n", "<A->>", "<CMD>BufferMoveNext<CR>", { desc = "Barbar: Shuffle buffer right.", noremap = true, silent = true })
-- map("n", "<A-p>", "<CMD>BufferPin<CR>", { desc = "Barbar: Pin buffer.", noremap = true, silent = true })
map(
	"n",
	"<A-<>",
	"<CMD>BufferMovePrevious<CR>",
	{ desc = "Barbar: Shuffle buffer left.", noremap = true, silent = true }
)
map("n", "<LEADER>x", "<CMD>BufferClose<CR>", { desc = "Barbar: Close buffer.", noremap = true, silent = true })
map("n", "<C-p>", "<CMD>BufferPick<CR>", { desc = "Barbar: Magic buffer picker.", noremap = true, silent = true })

--
--
-- Windows/Panes/Splits
--
--
map("n", "<leader>q", "<CMD>q<CR>", { desc = "Close (:q)", remap = true })
map("n", "<leader>Q", "<CMD>qa<CR>", { desc = "Close all (:qa)", remap = true })
map("n", "<S-Right>", "<CMD>vsplit<CR><C-l>", { desc = "Vertical split", remap = true })
map("n", "<S-Down>", "<CMD>split<CR><C-j>", { desc = "Horizontal split", remap = true })
map("n", "<C-h>", "<c-w>h", { desc = "Move focus left" })
map("n", "<C-j>", "<c-w>j", { desc = "Move focus down" })
map("n", "<C-k>", "<c-w>k", { desc = "Move focus up" })
map("n", "<C-l>", "<c-w>l", { desc = "Move focus right" })
map("n", "<m-h>", "<c-w>5<", { desc = "Resize pane: 5<" })
map("n", "<m-j>", "<c-w>+", { desc = "Resize pane: +" })
map("n", "<m-k>", "<c-w>-", { desc = "Resize pane: -" })
map("n", "<m-l>", "<c-w>5>", { desc = "Resize pane: 5>" })

--
--
-- LSP
--
--
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
map("n", "<leader>of", vim.diagnostic.open_float, { desc = "Open floating diagnostic panel" })
map("v", "cm", "gc", { desc = "Toggle comment using visual mode / a motion", remap = true })
map("n", "cm", "gcc", { desc = "Toggle a line comment", remap = true })

--
--
-- Formatting
--
--
map("n", "<C-F>", function()
	require("conform").format()
end, { desc = "Reformat buffer" })

--
--
-- Random custom function stuff
--
--

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
end, { desc = "Split line", silent = true })

-- Replace default visual-in-word with my custom version
-- vim.keymap.del("n", "viw")

local function find_chars_in_current_line()
	local line = vim.api.nvim_get_current_line()
	local char = vim.fn.getcharstr()

	local cursor_pos = vim.api.nvim_win_get_cursor(0)
	local cursor_col = cursor_pos[2]

	local start_pos = nil
	local end_pos = nil

	-- If the cursor is at the start of the line
	if cursor_col == 0 then
		print("Start")
		start_pos = 0
		end_pos = line:sub(2, line:len()):find(char)

	-- If the cursor is at the end of the line
	elseif cursor_col == line:len() - 1 then
		print("End")
		start_pos = line:reverse():sub(2, line:len()):find(char)
		end_pos = line:len() - 1

		if start_pos ~= nil then
			start_pos = line:len() - start_pos - 1
		end

	-- If the cursor is somewhere in the middle
	else
		print("Middle")
		local lhs = line:sub(1, cursor_col)
		local rhs = line:sub(cursor_col + 2, line:len())

		start_pos = lhs:reverse():find(char)
		end_pos = rhs:find(char)

		if start_pos ~= nil then
			start_pos = lhs:len() - start_pos
		end

		if end_pos ~= nil then
			end_pos = end_pos + cursor_col
		end
	end

	return { start_pos, end_pos, line:len() }
end

local function select_range_on_this_line(range)
	local line = vim.api.nvim_get_current_line()
	local cursor_pos = vim.api.nvim_win_get_cursor(0)
	local start_pos = range[1]
	local end_pos = range[2]

	print("Selecting range: " .. start_pos .. "," .. end_pos)

	vim.api.nvim_win_set_cursor(0, { cursor_pos[1], start_pos })
	vim.cmd("normal! v")
	vim.api.nvim_win_set_cursor(0, { cursor_pos[1], end_pos })
end

map("n", "vi", function()
	local range = find_chars_in_current_line()
	if range[1] ~= nil and range[2] ~= nil then
		select_range_on_this_line({ range[1] + 1, range[2] - 1 })
	end
end, { desc = "Visual In <Character> (exclusive)" })

map("n", "vI", function()
	local range = find_chars_in_current_line()
	if range[1] ~= nil and range[2] ~= nil then
		select_range_on_this_line({ range[1], range[2] })
	end
end, { desc = "Visual In <Character> (inclusive)" })
