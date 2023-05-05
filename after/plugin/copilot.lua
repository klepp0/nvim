vim.g.copilot_enabled = 0
vim.g.copilot_no_tab_map = true

vim.keymap.set("n", "<leader>cp", "<cmd>silent :Copilot panel<CR>", { desc = "[C]opilot [P]anel" })

vim.api.nvim_set_keymap('i', '<C-space>', 'copilot#Accept("<CR>")', { silent = true, expr = true })

vim.keymap.set("i", "<C-j>", "<Plug>(copilot-suggest)")
vim.keymap.set("i", "<C-k>", "<Plug>(copilot-dismiss)")
vim.keymap.set("i", "<C-l>", "<Plug>(copilot-next)")
vim.keymap.set("i", "<C-h>", "<Plug>(copilot-previous)")
