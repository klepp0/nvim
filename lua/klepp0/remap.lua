-- split window
vim.keymap.set(
	"n",
	"<C-x>",
	"<cmd>silent :vsp<CR> :wincmd l<CR>",
	{ desc = "split window at the [x]-axis (horizontally)" }
)
vim.keymap.set(
	"n",
	"<C-y>",
	"<cmd>silent :sp<CR> :wincmd j<CR>",
	{ desc = "split window at the [y]-axis (vertically)" }
)
