-- :Explore
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- center cursor
vim.keymap.set({ "n", "v" }, "<C-d>", "<C-d>zz")
vim.keymap.set({ "n", "v" }, "<C-u>", "<C-u>zz")

-- tab indentation
vim.keymap.set("n", "<tab>", ">>", { silent = true })
vim.keymap.set("n", "<S-tab>", "<<", { silent = true })
vim.keymap.set("v", "<tab>", ">gv", { silent = true })
vim.keymap.set("v", "<S-tab>", "<gv", { silent = true })

-- move highlighted lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- chmod +x file
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- execution
vim.keymap.set("n", "<C-p>", ":sp <CR> :term python % <CR>")
vim.keymap.set("n", "<C-w>", ":bd!<CR>")

-- to also apply changes of mass selection
vim.keymap.set("v", "<C-c", "<Esc>")

-- copy/paste to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d')
vim.keymap.set("x", "<leader>p", '"_P')

-- open new tmux window
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww<CR>", { desc = "Open [F]ull Screen Window" })
vim.keymap.set("n", "<C-s>", "<cmd>silent !tmux split-window -v<CR>", { desc = "[S]plit Window (Vertically)" })
vim.keymap.set("n", "<C-h>", "<cmd>silent !tmux split-window -h<CR>", { desc = "Split Window ([H]orizontally)" })
