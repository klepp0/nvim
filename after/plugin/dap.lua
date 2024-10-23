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

dap.adapters.python = {
	type = 'executable',
	command = 'python',
	args = { '-m', 'debugpy.adapter' },
}

dap.configurations.python = {
	{
		-- The first three options are required by nvim-dap
		type = 'python', -- Matches the adapter definition
		request = 'launch',
		name = 'Launch file',

		-- Options below are for debugpy
		program = '${file}', -- This configuration will launch the current file
		pythonPath = function()
			-- Use the virtual environment if available, otherwise use the default python
			local venv_path = os.getenv('VIRTUAL_ENV')
			if venv_path then
				return venv_path .. '/bin/python'
			else
				return 'python'
			end
		end,
	},
}
