vim.g.copilot_enabled = 0
vim.g.copilot_no_tab_map = true

vim.keymap.set("i", "<C-space>", 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false })
vim.keymap.set("i", "<C-h>", "<Plug>(copilot-dismiss)")
vim.keymap.set("i", "<C-k>", "<Plug>(copilot-prev)")
vim.keymap.set("i", "<C-j>", "<Plug>(copilot-next)")
vim.keymap.set("i", "<C-l>", "<Plug>(copilot-suggest)")
