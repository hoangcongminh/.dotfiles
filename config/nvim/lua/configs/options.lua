-- netrw
-- vim.g.netrw_browse_split = 0
-- vim.g.netrw_banner = 0
-- vim.g.netrw_winsize = 25

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

local options = {
	-- line numbers
	relativenumber = true,
	number = true,

	-- tab & indentation
	tabstop = 4,
	softtabstop = 4,
	shiftwidth = 4,
	shiftround = true,
	expandtab = true,

	smartindent = true,
	autoindent = true,

	-- scroll
	scrolloff = 8,
	sidescrolloff = 8,

	-- line wrapping
	wrap = false,

	-- search settings
	ignorecase = true,
	smartcase = true,
	hlsearch = false,
	incsearch = true,

	-- cursor
	guicursor = "",
	cursorline = true,
	cursorlineopt = "number,line",
	-- opt.cursorcolumn = true

	-- appearance
	termguicolors = true,
	signcolumn = "yes",
	-- opt.colorcolumn = "80"

	-- backspace
	backspace = "indent,eol,start",

	-- cmd
	-- opt.laststatus = 3
	cmdheight = 0,
	-- opt.cmdheight = 1

	-- others
	swapfile = false,
	backup = false,
	undodir = os.getenv("HOME") .. "/.vim/undodir",
	undofile = true,

	updatetime = 50,
	mouse = "a",
	completeopt = "menuone,noinsert,noselect",
	timeoutlen = 500 -- time to wait for a mapped sequence to complete (in milliseconds),
}

vim.opt.shortmess:append("c")
vim.opt.clipboard:append({ "unnamedplus" })

for option, value in pairs(options) do
	vim.opt[option] = value
end
