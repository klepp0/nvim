return {
	"theprimeagen/harpoon",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local mark = require("harpoon.mark")
		local ui = require("harpoon.ui")

		vim.keymap.set("n", "<C-a>", mark.add_file, { desc = "[A]ppend File to Harpoon" })
		vim.keymap.set("n", "<leader>c", mark.clear_all, { desc = "[C]lear Harpoon" })
		vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu, { desc = "Open Harpoon [E]xplorer" })

		for i = 1, 9 do
			vim.keymap.set("n", "<leader>" .. i, function()
				ui.nav_file(i)
			end, { desc = "Jump to Mark [" .. i .. "]" })
		end
		vim.keymap.set("n", "<leader>0", function()
			ui.nav_file(10)
		end, { desc = "Jump to Mark [10]" })
	end,
}
