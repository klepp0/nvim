vim.g.mapleader = " "

-- :Explore
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- center cursor 
vim.keymap.set({"n", "v"}, "<C-d>", "<C-d>zz")
vim.keymap.set({"n", "v"}, "<C-u>", "<C-u>zz")
