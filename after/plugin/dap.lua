local dap = require("dap")
local dapui = require("dapui")
local dappy = require("dap-python")
local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"

dapui.setup()
dappy.setup(path)

dap.listeners.before.attach.dapui_config = function()
	dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
	dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	dapui.close()
end

local opts = { noremap = true, silent = true }

vim.keymap.set('n', '<leader>dc', function() dap.continue() end, opts)
vim.keymap.set('n', '<leader>db', function() dap.toggle_breakpoint() end, opts)
vim.keymap.set('n', '<leader>dn', function() dap.sep_over() end, opts)
vim.keymap.set('n', '<leader>di', function() dap.set_into() end, opts)
vim.keymap.set('n', '<leader>do', function() dap.set_out() end, opts)
vim.keymap.set('n', '<leader>dt', function() dapui.toggle() end, opts)
