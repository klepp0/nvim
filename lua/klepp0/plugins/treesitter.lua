return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		{ "nvim-treesitter/playground" },
	},
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = { "python", "lua", "javascript" },
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
		})
	end,
}
