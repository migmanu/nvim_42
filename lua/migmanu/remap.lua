vim.g.mapleader = " "

-- Open Explorer
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

--move selection
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

--center cursor in search
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

--replace current selected word
vim.keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])


--use CTRL + l to move cursor right in insert mode
vim.keymap.set("i", "<C-l>", "<right>")


-- trouble keymaps
vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "<leader>xr", "<cmd>TroubleToggle lsp_references<cr>",
  {silent = true, noremap = true}
)
