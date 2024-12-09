local treesitter = require('nvim-treesitter.configs')

treesitter.setup {
	ensure_installed = { 'python', 'lua', 'javascript' }, -- Add languages you use
	auto_install = true,
	highlight = {
		enable = true, -- Enable Treesitter highlighting
		additional_vim_regex_highlighting = false,
	},
}
