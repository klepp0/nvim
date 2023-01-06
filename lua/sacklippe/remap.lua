vim.g.mapleader = " "

-- :Explore
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- center cursor 
vim.keymap.set({"n", "v"}, "<C-d>", "<C-d>zz")
vim.keymap.set({"n", "v"}, "<C-u>", "<C-u>zz")

-- tab indentation
vim.keymap.set({"n", "v"}, "<tab>", "><CR>", { silent = true })
vim.keymap.set({"n", "v"}, "<s-tab>", "<<CR>", { silent = true })

-- move highlighted lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- chmod +x file
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- execution
vim.keymap.set("n", "<C-R>", ":sp <CR> :term python % <CR>")
vim.keymap.set("n", "<C-W>", ":bd!<CR>")

-- copy/paste to clipboard
vim.api.nvim_set_keymap("", "<leader>y", "+y", { silent = true })
vim.api.nvim_set_keymap("", "<leader>Y", "+Y", { silent = true })
vim.api.nvim_set_keymap("", "<leader>d", "+d", { silent = true })
vim.api.nvim_set_keymap("", "<leader>D", "+D", { silent = true })
vim.api.nvim_set_keymap("", "<leader>p", "+p", { silent = true })
vim.api.nvim_set_keymap("", "<leader>P", "+P", { silent = true })
