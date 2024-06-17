local servers = {
	["bashls"] = {},
	["cssls"] = {},
	["html"] = {},
	["lua_ls"] = {},
	["tsserver"] = {},
	["pylsp"] = {},
}

return {
	{
		-- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			"williamboman/mason.nvim",
			{
				"williamboman/mason-lspconfig.nvim",
			},
			-- Additional lua configuration, makes nvim stuff amazing!
			{
				"folke/neodev.nvim",
				opts = {},
			},

			-- Interaction between cmp and lspconfig
			"hrsh7th/cmp-nvim-lsp",
		},
		init = function()
			-- disable lsp watcher. Too slow on linux
			local ok, wf = pcall(require, "vim.lsp._watchfiles")
			if ok then
				wf._watchfunc = function()
					return function() end
				end
			end
		end,
		config = function()
			local mason_lspconfig = require("mason-lspconfig")

			require("mason").setup()
			-- Ensure the servers above are installed
			mason_lspconfig.setup({
				ensure_installed = vim.tbl_keys(servers),
			})

			mason_lspconfig.setup_handlers({
				function(server_name)
					if server_name ~= "jdtls" then
						require("lspconfig")[server_name].setup({
							settings = servers[server_name],
						})
					end
				end,
			})
			for name, icon in pairs(require("config.icons").diagnostics) do
				name = "DiagnosticSign" .. name
				vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
			end
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		event = "LspAttach",
		dependencies = { "neovim/nvim-lspconfig" },
		opts = function()
			local nls = require("null-ls")
			local builtin = nls.builtins
			return {
				sources = {
					builtin.formatting.prettier,
					builtin.formatting.stylua,
					builtin.diagnostics.pylint,
					builtin.diagnostics.stylelint,
					builtin.formatting.shfmt,
				},
			}
		end,
	},

	{
		"folke/trouble.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
		},
		cmd = { "Trouble", "TroubleToggle" },
		opts = {},
	},

	{
		"williamboman/mason.nvim",
		cmd = { "Mason" },
		opts = {
			ensure_installed = {
				"bashls",
				"beautysh",
				"cssls",
				"html",
				"lua_ls",
				"prettier",
				"pylint",
				"pylsp",
				"shellcheck",
				"stylua",
				"tsserver",
			},
		},
		config = function(_, opts)
			vim.api.nvim_create_user_command("MasonInstallAll", function()
				vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
			end, {})
		end,
	},
}
