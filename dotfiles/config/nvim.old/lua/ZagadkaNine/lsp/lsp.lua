local status_mason, mason = pcall(require, "mason")
if (not status_mason) then return end
local status_mason_lspconfig, lspconfig = pcall(require, "mason-lspconfig")
if (not status_mason_lspconfig) then return end
local status_lspconfig, nvim_lsp = pcall(require, "lspconfig")
if (not status_lspconfig) then return end

mason.setup({
})

lspconfig.setup {
  ensure_installed = { "pyright", "lua_ls" },
}


--local protocol = require('vim.lsp.protocol')

--local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
---- capabilities.textDocument.completion.completionItem.snippetSupport = true

--local on_attach = function(client, bufnr)
--  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

--  --Enable completion triggered by <c-x><c-o>
--  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
--  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

--  -- Mappings.
--  local opts = { noremap = true, silent = true }

--  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
--  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
--  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
--  --buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
--  vim.api.nvim_create_autocmd("CursorHold", {
--    buffer = bufnr,
--    callback = function()
--      local opts_ = {
--        focusable = false,
--        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
--        border = 'rounded',
--        source = 'always',
--        prefix = ' ',
--        scope = 'cursor',
--      }
--      vim.diagnostic.open_float(nil, opts_)
--    end
--  })
--end

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

nvim_lsp.pyright.setup{
    -- on_attach = on_attach,
    -- capabilities = capabilities,
    -- filetypes = {"python"},
}

nvim_lsp.lua_ls.setup {
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    enable_format_on_save(client, bufnr)
  end,
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },

      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false
      },
    },
  },
}
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


-- nvim_lsp.rust_analyzer.setup{
--     capabilities = capabilities,
-- }

-- -- nvim_lsp.terraformls.setup{
-- --     capabilities = capabilities
-- -- }  

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

