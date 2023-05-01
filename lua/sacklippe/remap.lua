-- :Explore
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- center cursor
vim.keymap.set({ "n", "v" }, "<C-d>", "<C-d>zz")
vim.keymap.set({ "n", "v" }, "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- tab indentation
vim.keymap.set("n", "<tab>", ">>4l", { silent = true })
vim.keymap.set("n", "<S-tab>", "<<4h", { silent = true })
vim.keymap.set("v", "<tab>", ">gvl", { silent = true })
vim.keymap.set("v", "<S-tab>", "<gvh", { silent = true })

-- move highlighted lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- chmod +x file
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- execution
vim.keymap.set("n", "<C-p>", ":sp <CR> :term poetry run python % <CR>")

-- to also apply changes of mass selection
vim.keymap.set("v", "<C-c", "<Esc>")

-- copy/paste to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')
vim.keymap.set({ "n", "v" }, "<leader>d", '"+d')
--vim.keymap.set({ "n", "v" }, "<leader>p", '"+p')
vim.keymap.set({ "n" }, "<leader>Y", '"+Y')
vim.keymap.set({ "n" }, "<leader>D", '"+D')
vim.keymap.set({ "n" }, "<leader>P", '"+P')

-- quick nav in quickfix / location list
vim.keymap.set("n", "C-k", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "C-j", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>-k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>-j", "<cmd>lprev<CR>zz")

-- split window
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww<CR>", { desc = "Open [F]ull Screen Window" })
vim.keymap.set("n", "<C-s>", "<cmd>silent :vsp<CR> :wincmd l<CR>", { desc = "[S]plit Window (Vertically)" })
vim.keymap.set("n", "<C-h>", "<cmd>silent :sp<CR> :wincmd j<CR>", { desc = "Split Window ([H]orizontally)" })

-- create integrate terminal session
vim.keymap.set("n", "<leader>t", "<cmd>silent :term zsh<CR>i clear<CR>", { desc = "Open [T]erminal" })
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>", { noremap = true })
vim.keymap.set("t", "<C-w>", "<C-\\><C-n><C-w>")
vim.keymap.set("t", "<C-d>", "<C-d><C-d>")
