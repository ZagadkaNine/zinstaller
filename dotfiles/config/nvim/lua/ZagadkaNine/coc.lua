vim.cmd 'autocmd BufRead,BufNewFile *.yml set filetype=yaml.ansible'

vim.cmd 'inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#next(1): CheckBackspace() ? "<Tab>" : coc#refresh()'
vim.cmd 'inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "<C-h>"'
