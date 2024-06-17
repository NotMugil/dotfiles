return {
	{
		"folke/which-key.nvim",
		-- event = "VeryLazy",
		keys = {"<leader>"},
		config = function()
			local wk = require("which-key")
			wk.setup({
				key_labels = {
					["<space>"] = "SPC",
					["<leader>"] = "SPC",
					["<cr>"] = "RET",
					["<tab>"] = "TAB",
				},
				icons = {
					breadcrumb = "",
					group = " ",
				},
			})

			wk.register({
				["<leader>l"] = { name = "Line" },
				["<leader>w"] = { name = "Workspace" },
				["<leader>b"] = { name = "Buffer" },
				["<leader>s"] = { name = "Symbol" },
				["<leader>a"] = { name = "Add" },
				["<leader>d"] = { name = "Remove" },
				["<leader>o"] = { name = "Open" },
				["<leader>f"] = { name = "Find" },
			})
		end,
	},
}
