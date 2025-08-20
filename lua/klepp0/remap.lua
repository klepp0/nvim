-- split window
vim.keymap.set(
	"n",
	"<C-x>",
	"<cmd>silent :sp<CR> :wincmd j<CR>",
	{ desc = "Split window at the [x]-axis (horizontally)" }
)
vim.keymap.set(
	"n",
	"<C-y>",
	"<cmd>silent :vsp<CR> :wincmd l<CR>",
	{ desc = "Split window at the [y]-axis (vertically)" }
)

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<C-n>", vim.diagnostic.goto_next, { desc = "Go to [n]ext diagnostic message" })
vim.keymap.set("n", "<C-p>", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds for split navigation
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Explore (:Ex)
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Center cursor
vim.keymap.set({ "n", "v" }, "<C-d>", "<C-d>zz")
vim.keymap.set({ "n", "v" }, "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Tab indentation
vim.keymap.set("i", "<S-tab>", "<C-d>", { silent = true })
vim.keymap.set("n", "<tab>", ">>4l", { silent = true })
vim.keymap.set("n", "<S-tab>", "<<4h", { silent = true })
vim.keymap.set("v", "<tab>", ">gvl", { silent = true })
vim.keymap.set("v", "<S-tab>", "<gvh", { silent = true })

-- Move highlighted lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Copy/paste to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>d", '"+d', { desc = "Delete and copy to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set({ "n" }, "<leader>Y", '"+Y', { desc = "Copy line to system clipboard" })
vim.keymap.set({ "n" }, "<leader>D", '"+D', { desc = "Delete line and copy to system clipboard" })


-- Format code
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
