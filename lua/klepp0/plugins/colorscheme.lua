return {
	"rose-pine/neovim",
	priority = 1000,
	init = function()
		vim.cmd.colorscheme("rose-pine-main")
		vim.cmd.hi("Comment gui=none")
	end,
}
