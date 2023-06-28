require("ZagadkaNine.packer")
require("ZagadkaNine.lsp.lsp")
require("ZagadkaNine.set")
require("ZagadkaNine.remap")
require("ZagadkaNine.makefile")

-- local augroup = vim.api.nvim_create_augroup
-- local autocmd = vim.api.nvim_create_autocmd
-- local yank_group = augroup('HighlightYank', {})

-- vim.notify = require("notify")
-- vim.cmd 'autocmd BufRead,BufNewFile *.yml set filetype=yaml.ansible'

-- require("notify").setup({
--   background_colour = "#000000",
-- })

-- autocmd('TextYankPost', {
--     group = yank_group,
--     pattern = '*',
--     callback = function ()
--         vim.highlight.on_yank({
--             higroup = 'InkSearch',
--             timeout = 40
--         })
--     end
-- })

-- require('hardline').setup {}
