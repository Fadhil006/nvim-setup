local opt = vim.opt

vim.opt.clipboard = "unnamedplus"

-- ===== UI =====
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.wrap = false

-- ===== Cursor / scrolling =====
opt.scrolloff = 5
opt.sidescrolloff = 5

-- ===== Indentation =====
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

-- ===== Search =====
opt.ignorecase = true
opt.smartcase = true

-- ===== Performance / visuals =====
opt.termguicolors = true
opt.updatetime = 250

-- ===== Split behavior =====
opt.splitright = true
opt.splitbelow = tru-- Cursor line underline (instead of background)
vim.cmd([[
  highlight CursorLine gui=underline cterm=underline
]])

