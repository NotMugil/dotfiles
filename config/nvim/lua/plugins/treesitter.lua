vim.filetype.add({
  pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
})

vim.bo.commentstring = "# %s"

return {
	{
		"nvim-treesitter/nvim-treesitter",
		-- lazy = false,
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				-- Add languages to be installed here that you want installed for treesitter
				ensure_installed = {
					"bash",
					"html",
					"javascript",
					"lua",
					"python",
					"vim",
					"vimdoc",
					"yaml",
					"hyprlang"
				},

				-- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
				auto_install = true,

				highlight = { enable = true },
				indent = { enable = true },
				incremental_selection = {
					enable = false,
				},
				context_commentstring = {
					enabled = true,
				},
				textobjects = {
					select = {
						enable = true,
						lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
						keymaps = {
							-- You can use the capture groups defined in textobjects.scm
							["aa"] = "@parameter.outer",
							["ia"] = "@parameter.inner",
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
						},
					},
					move = {
						enable = true,
						set_jumps = true, -- whether to set jumps in the jumplist
						goto_next_start = {
							["]m"] = "@function.outer",
							["]]"] = "@class.outer",
						},
						goto_next_end = {
							["]M"] = "@function.outer",
							["]["] = "@class.outer",
						},
						goto_previous_start = {
							["[m"] = "@function.outer",
							["[["] = "@class.outer",
						},
						goto_previous_end = {
							["[M"] = "@function.outer",
							["[]"] = "@class.outer",
						},
					},
					swap = {
						enable = true,
						swap_next = {
							["<leader>sj"] = "@parameter.inner",
						},
						swap_previous = {
							["<leader>sk"] = "@parameter.inner",
						},
					},
				},
			})
		end,
	},
}
