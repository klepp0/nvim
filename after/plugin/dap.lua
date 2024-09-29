local dap = require("dap")
local dapui = require("dapui")
local dappy = require("dap-python")

dapui.setup()
dappy.setup()

local opts = { noremap = true, silent = true }

vim.keymap.set('n', '<leader>dc', function() dap.continue() end, opts)
vim.keymap.set('n', '<leader>db', function() dap.toggle_breakpoint() end, opts)
vim.keymap.set('n', '<leader>dn', function() dap.sep_over() end, opts)
vim.keymap.set('n', '<leader>di', function() dap.set_into() end, opts)
vim.keymap.set('n', '<leader>do', function() dap.set_out() end, opts)
vim.keymap.set('n', '<leader>dt', function() dapui.toggle() end, opts)
