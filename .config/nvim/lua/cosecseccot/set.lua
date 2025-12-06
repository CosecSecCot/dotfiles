vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed
vim.g.have_nerd_font = true

if vim.g.neovide then
	vim.o.guifont = "FiraCode Nerd Font:h16"

	vim.g.neovide_scroll_animation_length = 0.2
	vim.g.neovide_cursor_animation_length = 0.005
	-- vim.g.neovide_cursor_animation_length = 0

	-- vim.g.neovide_transparency = 0.95
	-- vim.g.transparency = 0.95

	vim.g.neovide_floating_blur_amount_x = 5.0
	vim.g.neovide_floating_blur_amount_y = 5.0

	vim.g.neovide_floating_shadow = true
	vim.g.neovide_floating_z_height = 10
	vim.g.neovide_light_angle_degrees = 45
	vim.g.neovide_light_radius = 10

	-- vim.g.neovide_padding_top = 0
	-- vim.g.neovide_padding_bottom = 0
	-- vim.g.neovide_padding_right = 10
	-- vim.g.neovide_padding_left = 10

	vim.g.neovide_scale_factor = 1.0
	local change_scale_factor = function(delta)
		vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
	end
	vim.keymap.set("n", "<C-=>", function()
		change_scale_factor(1.25)
	end)
	vim.keymap.set("n", "<C-->", function()
		change_scale_factor(1 / 1.25)
	end)

	vim.g.experimental_layer_grouping = true
end

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.o.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.o.relativenumber = true

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = "unnamedplus"

-- Enable break indent
-- vim.o.breakindent = true

-- Save undo history
-- vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = "auto"

-- Pumblend and WinBlend for translucent floats
-- vim.o.pumblend = 10
-- vim.o.winbl = 5

vim.o.wrap = false

vim.o.swapfile = false
vim.o.backup = false

vim.o.hlsearch = true
vim.o.incsearch = true

vim.o.scrolloff = 8

vim.o.termguicolors = true
-- Decrease update time
vim.o.updatetime = 50

-- Last status (for stausline)
vim.o.laststatus = 3

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.o.list = true
vim.opt.listchars = {
	tab = "» ",
	-- tab = "· ",
	trail = "·",
	nbsp = "␣",
	-- eol = "↲",
}

-- Preview substitutions live, as you type!
vim.o.inccommand = "split"

-- Netrw Banner
vim.g.netrw_banner = false

-- Show which line your cursor is on
vim.o.cursorline = true

vim.filetype.add({
	extension = {
		frag = "glsl",
		vert = "glsl",
	},
})
