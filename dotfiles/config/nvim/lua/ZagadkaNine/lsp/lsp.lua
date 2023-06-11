-- local nvim_lsp = require('lspconfig')
-- local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
-- capabilities.textDocument.completion.completionItem.snippetSupport = true


-- require("nvim-lsp-installer").setup({
--     automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
--     ui = {
--         icons = {
--             server_installed = "✓",
--             server_pending = "➜",
--             server_uninstalled = "✗"
--         }
--     }
-- })

-- nvim_lsp.intelephense.setup({
--     settings = {
--         intelephense = {
--             stubs = {
--                 "bcmath",
--                 "bz2",
--                 "Core",
--                 "curl",
--                 "date",
--                 "dom",
--                 "fileinfo",
--                 "filter",
--                 "gd",
--                 "gettext",
--                 "hash",
--                 "iconv",
--                 "imap",
--                 "intl",
--                 "json",
--                 "libxml",
--                 "mbstring",
--                 "mcrypt",
--                 "mysql",
--                 "mysqli",
--                 "password",
--                 "pcntl",
--                 "pcre",
--                 "PDO",
--                 "pdo_mysql",
--                 "Phar",
--                 "readline",
--                 "regex",
--                 "session",
--                 "SimpleXML",
--                 "sockets",
--                 "sodium",
--                 "standard",
--                 "superglobals",
--                 "tokenizer",
--                 "xml",
--                 "xdebug",
--                 "xmlreader",
--                 "xmlwriter",
--                 "zip",
--                 "zlib",
--                 "wordpress-stubs",
--                 "woocommerce-stubs",
--                 "acf-pro-stubs",
--                 "wordpress-globals",
--                 "wp-cli-stubs",
--                 "genesis-stubs",
--                 "polylang-stubs"
--             },
--             environment = {
--             },
--             files = {
--                 maxSize = 5000000;
--             };
--         };
--     },
--     capabilities = capabilities,
-- });

-- nvim_lsp.vimls.setup{
--     capabilities = capabilities,
-- }
-- nvim_lsp.ansiblels.setup{
-- }
-- nvim_lsp.cssls.setup{
--     capabilities = capabilities,
-- }
-- nvim_lsp.html.setup{
--     capabilities = capabilities,
-- }
-- nvim_lsp.bashls.setup{
--     capabilities = capabilities,
-- }

-- nvim_lsp.cmake.setup{
--     capabilities = capabilities,
-- }

-- nvim_lsp.ltex.setup{
--     settings = {
--         ltex = {
--             enabled = true,
--             language = "fr",
--         },
--     },
-- }

-- nvim_lsp.jsonls.setup{
--     capabilities = capabilities,
-- }

-- nvim_lsp.vimls.setup{
--     capabilities = capabilities,
-- }

-- nvim_lsp.tsserver.setup{
--     capabilities = capabilities,
-- }

-- nvim_lsp.pyright.setup{
--     capabilities = capabilities,
-- }

-- nvim_lsp.rust_analyzer.setup{
--     capabilities = capabilities,
-- }

-- nvim_lsp.terraformls.setup{
--     capabilities = capabilities
-- }  

-- vim.ui.select = require("popui.ui-overrider")

-- require'nvim-lightbulb'.update_lightbulb({
--     sign = {
--         enabled = true,
--         priority = 10,
--     },
--     float = {
--         enabled = false,
--     },
--     virtual_text = {
--         enabled = true,
--         hl_mode = "combine",
--     },
--     status_text = {
--         enabled = true,
--     }
-- })

-- vim.api.nvim_create_autocmd({'CursorHoldI', 'CursorHold'}, {
--     pattern = '*',
--     callback = function()
--         require'nvim-lightbulb'.update_lightbulb()
--     end,
-- })


-- local notify = require('notify')
-- vim.lsp.handlers['window/showMessage'] = function(_, result, ctx)
--     local client = vim.lsp.get_client_by_id(ctx.client_id)
--     local lvl = ({
--         'ERROR',
--         'WARN',
--         'INFO',
--         'DEBUG',
--     })[result.type]
--     notify(result.message, lvl, {
--         title = 'LSP | ' .. client.name,
--         timeout = 10000,
--         keep = function()
--             return lvl == 'ERROR' or lvl == 'WARN'
--         end,
--     })
-- end

