local dap = require("dap")
local dapui = require("dapui")
local dappy = require("dap-python")
local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"

local function detect_python_path()
	-- 1) If Neovim was launched from within an activated virtualenv (VIRTUAL_ENV), use it:
	if vim.env.VIRTUAL_ENV then
		return vim.env.VIRTUAL_ENV .. "/bin/python"
	end

	-- 2) If there's a .venv folder in the current project, use that:
	local cwd = vim.fn.getcwd()
	if vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
		return cwd .. "/.venv/bin/python"
	end

	-- 3) If Conda is active, use that environment:
	if vim.env.CONDA_PREFIX then
		return vim.env.CONDA_PREFIX .. "/bin/python"
	end

	-- 4) If Poetry venv is set up, detect that (slightly trickier, but you can guess or parse `poetry env info --path`)
	--    For a basic guess, use .venv or a known location:
	--  if vim.fn.executable(cwd .. "/path/to/poetry/venv/bin/python") == 1 then
	--    return cwd .. "/path/to/poetry/venv/bin/python"
	--  end

	-- 5) Fallback: system Python
	return "/usr/bin/python"
end

dapui.setup()
dappy.setup(
	detect_python_path(),
	{
		console = "integratedTerminal",
		justMyCode = false,
	}
)
dappy.test_runner = "pytest"
dappy.test_runner_args = { "--capture=no" }

local opts = { noremap = true, silent = true }

vim.keymap.set('n', '<leader>dc', function() dap.continue() end, opts)
vim.keymap.set('n', '<leader>db', function() dap.toggle_breakpoint() end, opts)
vim.keymap.set('n', '<leader>dn', function() dap.step_over() end, opts)
vim.keymap.set('n', '<leader>di', function() dap.step_into() end, opts)
vim.keymap.set('n', '<leader>do', function() dap.step_out() end, opts)
vim.keymap.set('n', '<leader>dt', function() dapui.toggle() end, opts)
vim.keymap.set('n', '<leader>dpr', function() dappy.test_method() end, opts)

dap.listeners.after.event_initialized.dapui_config = function()
	dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	dapui.close()
end

dap.set_exception_breakpoints({ "raised", "uncaught", "userUnhandled" })
