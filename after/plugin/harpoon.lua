local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<C-a>", mark.add_file, { desc = "[A]ppend File to Harpoon" })
vim.keymap.set("n", "<leader>c", mark.clear_all, { desc = "[C]lear Harpoon" })
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu, { desc = "Open Harpoon [E]xplorer" })

vim.keymap.set("n", "<leader>1", function()
	ui.nav_file(1)
end, { desc = "Jump to Mark [1]" })
vim.keymap.set("n", "<leader>2", function()
	ui.nav_file(2)
end, { desc = "Jump to Mark [2]" })
vim.keymap.set("n", "<leader>3", function()
	ui.nav_file(3)
end, { desc = "Jump to Mark [3]" })
vim.keymap.set("n", "<leader>4", function()
	ui.nav_file(3)
end, { desc = "Jump to Mark [4]" })
