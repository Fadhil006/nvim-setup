vim.g.mapleader = " "

-- Save
vim.keymap.set("n", "<leader>w", ":w<CR>")

-- Run C++ code
vim.keymap.set("n", "<leader>r", ":w<CR>:!g++ % -O2 -std=gnu++17 && ./a.out < input.txt > output.txt<CR>")

-- Copy whole code
vim.keymap.set("n", "<leader>c", "ggVGy")

-- Quit
vim.keymap.set("n", "<leader>q", ":q<CR>")

-- file tree
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
