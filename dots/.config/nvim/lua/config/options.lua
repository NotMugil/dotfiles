-- indentation
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = "a"

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = "unnamedplus"

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- search and replace
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = false
vim.o.incsearch = true
vim.o.gdefault = true

-- user interface
vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.termguicolors = true
vim.o.scrolloff = 8
vim.o.signcolumn = "yes"
vim.o.cursorline = false

-- file management
vim.o.swapfile = false
vim.o.backup = false
vim.o.undofile = true
vim.o.autoread = true
vim.o.autowrite = true
vim.o.hidden = true

-- use system clipboard
vim.o.clipboard = "unnamedplus"

-- hide default statusline and ruler in dashboard
vim.cmd([[autocmd FileType alpha set laststatus=0]])
vim.cmd([[autocmd FileType alpha set noruler]])

-- set terminal cursor back to vertical beam on exit
vim.api.nvim_create_autocmd("ExitPre", {
	group = vim.api.nvim_create_augroup("Exit", { clear = true }),
	command = "set guicursor=a:ver90",
	desc = "Set cursor back to beam when leaving Neovim.",
})

-- Hide "disable mouse" stuff in context menu cuz I like mouse lol
vim.cmd([[
  aunmenu PopUp.How-to\ disable\ mouse
  aunmenu PopUp.-1-
]])

vim.cmd.colorscheme('tokyonight')
