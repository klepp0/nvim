-- Autocomplete
local cmp = require("cmp")
local luasnip = require("luasnip")

luasnip.config.setup({})

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = {
		["<C-n>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback() -- falls back to normal <C-n> if no menu
			end
		end, { "i", "c" }),
		["<C-p>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end, { "i", "c" }),
		["<CR>"] = cmp.mapping.confirm({ select = false }), -- only confirm explicitly selected item
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "path" },
	},
	preselect = cmp.PreselectMode.None, -- don't auto-select first item (optional)
	experimental = { ghost_text = false },
})
