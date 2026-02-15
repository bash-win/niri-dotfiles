vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.keymap.set("n", "<leader>cd", vim.cmd.Ex)
vim.keymap.set("i", "jj", "<Esc>", { noremap = true})
vim.keymap.set({"n", "i", "v"}, "<leader>y", "+y<CR>")

