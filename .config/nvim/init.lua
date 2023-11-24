-- plugins
require 'paq' {
	'savq/paq-nvim',

	'neovim/nvim-lspconfig',

	'ap/vim-buftabline',

	'nvim-lua/plenary.nvim', -- needed for telescope
	'nvim-telescope/telescope-fzf-native.nvim',
	'nvim-telescope/telescope.nvim',

	'evanleck/vim-svelte',
	'pangloss/vim-javascript',
	'HerringtonDarkholme/yats.vim',
	'Shougo/context_filetype.vim',
}

-- plugin settings
vim.g.vim_svelte_plugin_use_typescript = 1

-- cursor settings
vim.opt.guicursor = [[n-v-c:block,i-ci-ve:ver25,a:blinkon250-blinkoff250,r:hor50]]
vim.cmd("highlight Cursor gui=NONE guifg=bg guibg=fg")

-- color scheme
vim.opt.background = 'dark'

local Black   = "0"
local Red     = "1"
local Green   = "2"
local Yellow  = "3"
local Blue    = "4"
local Magenta = "5"
local Cyan    = "6"
local White   = "7"
local BrightBlack   = "8"
local BrightRed     = "9"
local BrightGreen   = "10"
local BrightYellow  = "11"
local BrightBlue    = "12"
local BrightMagenta = "13"
local BrightCyan    = "14"
local BrightWhite   = "15"
local None = "none"

local function color(group, fg, bg)
	vim.cmd("highlight " .. group .. " ctermfg=" .. fg .. " ctermbg=" .. bg)
end

vim.cmd("highlight Normal     ctermfg=7")
color("Normal", White, None)

color("Whitespace", BrightBlack,   None)
color("LineNr",	    BrightBlack,   None)
color("Comment",    Green,	   None)
color("Constant",   Blue,          None)
color("Number",	    Yellow,        None)
color("String",	    BrightGreen,   None)
color("Character",  BrightBlue,    None)
color("Identifier", Blue,          None)
color("Statement",  BrightMagenta, None)
color("Type",	    Cyan,          None)
color("Operator",   BrightWhite,   None)
color("PreProc",    BrightBlue,    None)

vim.cmd("highlight StatusLine	     ctermbg=0 ctermfg=7")
vim.cmd("highlight StatusLineNC      ctermbg=8 ctermfg=0")
vim.cmd("highlight TabLine	     cterm=none ctermfg=8")
vim.cmd("highlight BufTabLineCurrent ctermbg=0 ctermfg=15 cterm=bold")
vim.cmd("highlight BufTabLineActive  ctermbg=0 ctermfg=8")
vim.cmd("highlight BufTabLineHidden  cterm=none ctermfg=8")
vim.cmd("highlight BufTabLineFill    cterm=none ctermfg=8")

vim.cmd("highlight Pmenu    ctermbg=0 ctermfg=15")
vim.cmd("highlight PmenuSel ctermbg=15 ctermfg=0")

-- environment settings
vim.cmd("syntax enable")

vim.opt.list = true
vim.opt.softtabstop = 4

vim.opt.clipboard = 'unnamedplus'

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.showcmd = true
vim.opt.hlsearch = true

vim.opt.undodir = vim.fn.expand("~/.vimdid/")
vim.opt.undofile = true

vim.keymap.set('n', '<Return>', ':noh<CR><Return>')

-- commands
vim.api.nvim_create_user_command('W', "w", {}) -- because this always becomes uppercase for some reason

-- cursor centering for easier prose writing
vim.g.forceCursorCenter = false

local function toggle_cursor_center()
	vim.g.forceCursorCenter = not vim.g.forceCursorCenter
	if vim.g.forceCursorCenter then
	print("Cursor centering enabled")
	else
	print("Cursor centering disabled")
	end
end

vim.api.nvim_create_autocmd({"CursorMoved", "InsertLeave"}, {
	pattern = "*",
	callback = function()
	if vim.g.forceCursorCenter then
		vim.api.nvim_command('normal! zz')
	end
    end
})

vim.api.nvim_create_user_command('ToggleCenter', toggle_cursor_center, {})
vim.keymap.set('', '<leader>c', ':ToggleCenter<CR>')

-- config keybindings
local initFile = '~/.config/nvim/init.lua'
local cmdRefresh = ':so' .. initFile .. '<CR>'
vim.keymap.set('n', '<leader>,e', ':e ' .. initFile .. '<CR>')
vim.keymap.set('n', '<leader>,r', cmdRefresh)
vim.keymap.set('n', '<leader>,p', cmdRefresh .. ':PaqSync<CR>')

-- buffer keybindings
vim.keymap.set('', '<leader>[', ':bp!<CR>')
vim.keymap.set('', '<leader>]', ':bn!<CR>')
vim.keymap.set('', '<leader>w', ':bd!<CR>')
vim.keymap.set('', '<leader>l', ':ls!<CR>')
vim.keymap.set('', '<C-s>', ':wall<CR>')

vim.keymap.set('', '<leader>p' , ":lua require'telescope.builtin'.find_files{hidden = true}<CR>")
vim.keymap.set('', '<leader>P' , ":lua require'telescope.builtin'.find_files{hidden = true, no_ignore = true}<CR>")
vim.keymap.set('', '<leader>b', ":lua require'telescope.builtin'.buffers{}<CR>")
vim.keymap.set('', '<leader>f', ":lua require'telescope.builtin'.live_grep{}<CR>")
