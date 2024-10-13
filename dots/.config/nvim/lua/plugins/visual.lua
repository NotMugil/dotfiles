return {
	{
		-- Set lualine as statusline
		"nvim-lualine/lualine.nvim",
		-- See `:help lualine.txt`
		event = { "BufReadPre", "BufNewFile", "FileType neo-tree" },
		opts = {
			options = {
				icons_enabled = true,
				theme = "tokyonight",
				disabled_filetypes = { statusline = { "dashboard", "alpha", "neo-tree" } },
				component_separators = "|",
				section_separators = { left = "", right = "" },
			},
		},
	},
	{
		"akinsho/bufferline.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = "nvim-tree/nvim-web-devicons",
		config = true,
		opts = {
			options = {
				always_show_bufferline = false,
				-- separator_style = "slant",
			},
			highlights = {
				fill = {
					bg = {
						attribute = "bg",
						highlight = "bg",
					},
				},
			},
		},
	},
	{
		"folke/tokyonight.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		-- config = function()
		-- 	-- load the colorscheme here
		-- 	vim.cmd([[colorscheme tokyonight]])
		-- end,
		opts = {
			style = "night",
			on_colors = function(colors)
				colors.bg = "#1a1b26"
			end
		}
	},
	{
		-- Adds git releated signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			-- See `:help gitsigns.txt`
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},
	{
		"NvChad/nvim-colorizer.lua",
		event = { "BufReadPost", "BufNewFile" },
		config = true,
		opts = {
			user_default_options = {
				css = true,
				RRGGBBAA = true,
				AARRGGBB = true,
				names = false,
			},
		},
	},
	-- noicer ui
	{
		"folke/noice.nvim",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			-- which key integration
			{
				"folke/which-key.nvim",
				config = true,
			},
			{ "MunifTanjim/nui.nvim" },
		},
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			routes = {
				{
					filter = {
						event = "msg_show",
						find = "%d+L, %d+B",
					},
					view = "mini",
				},
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
			},
		},
		-- stylua: ignore
		keys = {
			{
				"<S-Enter>",
				function() require("noice").redirect(vim.fn.getcmdline()) end,
				mode = "c",
				desc =
				"Redirect Cmdline"
			},
			{
				"<leader>snl",
				function() require("noice").cmd("last") end,
				desc =
				"Noice Last Message"
			},
			{
				"<leader>snh",
				function() require("noice").cmd("history") end,
				desc =
				"Noice History"
			},
			{ "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
			{
				"<leader>snd",
				function() require("noice").cmd("dismiss") end,
				desc =
				"Dismiss All"
			},
			{
				"<c-f>",
				function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end,
				silent = true,
				expr = true,
				desc =
				"Scroll forward",
				mode = {
					"i", "n", "s" }
			},
			{
				"<c-b>",
				function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end,
				silent = true,
				expr = true,
				desc =
				"Scroll backward",
				mode = {
					"i", "n", "s" }
			},
		},
	},
}
