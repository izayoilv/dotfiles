vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<leader>ss", ":w<CR>", { desc = "Save file" })
vim.keymap.set("n", "<leader>sq", ":wq<CR>", { desc = "Save and quit file" })
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })
vim.keymap.set("n", "<leader>Q", ":q!<CR>", { desc = "Force quit" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv", { silent = true, desc = "Move selection up" })
