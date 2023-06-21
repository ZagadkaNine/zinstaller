local nnoremap = require("ZagadkaNine.keymap").nnoremap
local inoremap = require("ZagadkaNine.keymap").nnoremap
local vnoremap = require("ZagadkaNine.keymap").nnoremap
local xnoremap = require("ZagadkaNine.keymap").nnoremap
local nmap = require("ZagadkaNine.keymap").nmap


nnoremap("<leader>pv", "<cmd>Ex<CR>")
nnoremap("<leader>f", "<cmd>Telescope find_files hidden=true<CR>")
nnoremap("<leader>g", "<cmd>Telescope grep_string<CR>")
nnoremap("<leader>k", "<cmd>Telescope keymaps<CR>")
nnoremap("<leader>e", "<cmd>NvimTreeToggle<CR>")

nnoremap("<C-j>", "<C-w><C-j>")
nnoremap("<C-k>", "<C-w><C-k>")
nnoremap("<C-l>", "<C-w><C-l>")
nnoremap("<C-h>", "<C-w><C-h>")

nnoremap("<C-d>", "<C-d>zz")
nnoremap("<C-u>", "<C-u>zz")

nnoremap("<leader>l", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>")
nnoremap("<leader>a", "<cmd>lua require('harpoon.mark').add_file()<CR>")
nnoremap("<leader>1", "<cmd>lua require('harpoon.ui').nav_file(1)<CR>")
nnoremap("<leader>2", "<cmd>lua require('harpoon.ui').nav_file(2)<CR>")
nnoremap("<leader>3", "<cmd>lua require('harpoon.ui').nav_file(3)<CR>")
nnoremap("<leader>4", "<cmd>lua require('harpoon.ui').nav_file(4)<CR>")
nnoremap("<leader>j", "<cmd>lua require('harpoon.ui').nav_next()<CR>")
nnoremap("<leader>h", "<cmd>lua require('harpoon.ui').nav_prev()<CR>")


nnoremap("<leader>v", "<cmd>vsplit<CR>")

-- saga
-- nnoremap("gd", "<cmd>Lspsaga peek_definition<CR>")
-- nnoremap("gh", "<cmd>Lspsaga lsp_finder<CR>")
-- nnoremap("gl", "<cmd>Lspsaga show_line_diagnostics<CR>")
-- nnoremap("gf", "<cmd>Lspsaga hover_doc<CR>")
-- nnoremap("ga", "<cmd>Lspsaga code_action<CR>")

-- nnoremap("gd", "<cmd>call CocActionAsync('jumpDefinition')<CR>")
-- nnoremap("gh", "<cmd>Lspsaga lsp_finder<CR>")
-- nnoremap("gl", "<cmd>Lspsaga show_line_diagnostics<CR>")
-- nnoremap("gf", "<cmd>Lspsaga hover_doc<CR>")
-- nnoremap("ga", "<cmd>Lspsaga code_action<CR>")

-- greatest remap ever
xnoremap("<leader>p", "\"_dP")

-- next greatest remap ever : asbjornHaland
nnoremap("<leader>y", "\"+y")
vnoremap("<leader>y", "\"+y")
nmap("<leader>Y", "\"+Y")

nnoremap("<leader>d", "\"_d")
vnoremap("<leader>d", "\"_d")

vnoremap("<leader>d", "\"_d")

-- This is going to get me cancelled
inoremap("<C-c>", "<Esc>")

makefile_sync = require("ZagadkaNine.makefile").sync
makefile_run = require("ZagadkaNine.makefile").run
commit = require("ZagadkaNine.quickcommit").commit

nnoremap("<leader>s", "<cmd>lua makefile_sync()<CR>")
nnoremap("<leader>r", "<cmd>lua makefile_run()<CR>")

vim.api.nvim_create_user_command("MS", "lua sync()", {})
vim.api.nvim_create_user_command("WIP", "lua commit()", {})


nnoremap("<S-h>", "<cmd>vertical resize +5<CR>")
nnoremap("<S-l>", "<cmd>vertical resize -5<CR>")
nnoremap("<S-j>", "<cmd>resize +5<CR>")
nnoremap("<S-k>", "<cmd>resize -5<CR>")

