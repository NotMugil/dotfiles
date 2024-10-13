if vim.g.neovide then
	vim.o.guifont = "SpaceMono Nerd Font:h15:#e-subpixelantialias:#h-none"
	vim.opt.linespace = -1

	-- Helper function for transparency formatting
	local alpha = function()
		return string.format("%x", math.floor(255 * vim.g.transparency))
	end
	-- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
	vim.g.neovide_transparency = 0.75
	vim.g.transparency = 0.75
	vim.g.neovide_background_color = "#1a1b26" .. alpha()

	vim.g.neovide_padding_top = 12
	vim.g.neovide_padding_bottom = 12
	vim.g.neovide_padding_right = 12
	vim.g.neovide_padding_left = 12
end
