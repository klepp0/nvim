vim.g.mapleader = " "

-- :Explore
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- center cursor 
vim.keymap.set({"n", "v"}, "<C-d>", "<C-d>zz")
vim.keymap.set({"n", "v"}, "<C-u>", "<C-u>zz")

-- chmod +x file
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- copy/paste to clipboard
vim.api.nvim_set_keymap("", "<leader>y", '"+y', { silent = true })
vim.api.nvim_set_keymap("", "<leader>Y", '"+Y', { silent = true })
vim.api.nvim_set_keymap("", "<leader>p", '"+p', { silent = true })
vim.api.nvim_set_keymap("", "<leader>P", '"+P', { silent = true })
