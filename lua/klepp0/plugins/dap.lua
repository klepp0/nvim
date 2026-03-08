return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
		"nvim-neotest/nvim-nio",
		"mfussenegger/nvim-dap-python",
		"williamboman/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		local dappy = require("dap-python")

		local function detect_python_path()
			if vim.env.VIRTUAL_ENV then
				return vim.env.VIRTUAL_ENV .. "/bin/python"
			end

			local cwd = vim.fn.getcwd()
			if vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
				return cwd .. "/.venv/bin/python"
			end

			if vim.env.CONDA_PREFIX then
				return vim.env.CONDA_PREFIX .. "/bin/python"
			end

			return "/usr/bin/python"
		end

		dapui.setup()
		dappy.setup(detect_python_path(), {
			console = "integratedTerminal",
			justMyCode = false,
		})
		dappy.test_runner = "pytest"
		dappy.test_runner_args = { "--capture=no" }

		local opts = { noremap = true, silent = true }

		vim.keymap.set("n", "<leader>dc", dap.continue, opts)
		vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, opts)
		vim.keymap.set("n", "<leader>dn", dap.step_over, opts)
		vim.keymap.set("n", "<leader>di", dap.step_into, opts)
		vim.keymap.set("n", "<leader>do", dap.step_out, opts)
		vim.keymap.set("n", "<leader>dt", dapui.toggle, opts)
		vim.keymap.set("n", "<leader>dpr", dappy.test_method, opts)

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
	end,
}
