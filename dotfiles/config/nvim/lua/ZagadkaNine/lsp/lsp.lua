local status_mason, mason = pcall(require,"mason")
if not status_mason then return end
mason.setup()
mason.setup { ensure_installed = { "ruff", "black", "mypy", "pyright" }}

local status_mason_lspconfig, mason_lspconfig = pcall(require,"mason-lspconfig")
if not status_mason_lspconfig then return end
mason_lspconfig.setup { ensure_installed = { "lua_ls", "pyright", "tsserver", "intelephense", "ansiblels", "cssls", "html", "bashls", "cmake", "ltex", "jsonls", "tsserver", "rust_analyzer", "terraformls" }}

local nvim_lsp = require('lspconfig')

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local luasnip = require('luasnip')
luasnip.config.set_config({
    history = true,
    updateevents = 'TextChanged,TextChangedI'
})

local cmp = require 'cmp'

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
    }
})
-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
    }, {
        -- { name = 'buffer' },
    })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})


nvim_lsp.pyright.setup{
    capabilities = capabilities,
}

nvim_lsp.lua_ls.setup{
    capabilities = capabilities,
}

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

nvim_lsp.intelephense.setup({
    settings = {
        intelephense = {
            stubs = {
                "bcmath",
                "bz2",
                "Core",
                "curl",
                "date",
                "dom",
                "fileinfo",
                "filter",
                "gd",
                "gettext",
                "hash",
                "iconv",
                "imap",
                "intl",
                "json",
                "libxml",
                "mbstring",
                "mcrypt",
                "mysql",
                "mysqli",
                "password",
                "pcntl",
                "pcre",
                "PDO",
                "pdo_mysql",
                "Phar",
                "readline",
                "regex",
                "session",
                "SimpleXML",
                "sockets",
                "sodium",
                "standard",
                "superglobals",
                "tokenizer",
                "xml",
                "xdebug",
                "xmlreader",
                "xmlwriter",
                "zip",
                "zlib",
                "wordpress-stubs",
                "woocommerce-stubs",
                "acf-pro-stubs",
                "wordpress-globals",
                "wp-cli-stubs",
                "genesis-stubs",
                "polylang-stubs"
            },
            environment = {
            },
            files = {
                maxSize = 5000000;
            };
        };
    },
    capabilities = capabilities,
});

nvim_lsp.ansiblels.setup{
}
nvim_lsp.cssls.setup{
    capabilities = capabilities,
}
nvim_lsp.html.setup{
    capabilities = capabilities,
}
nvim_lsp.bashls.setup{
    capabilities = capabilities,
}

nvim_lsp.cmake.setup{
    capabilities = capabilities,
}

nvim_lsp.ltex.setup{
    settings = {
        ltex = {
            enabled = true,
            language = "fr",
        },
    },
}

nvim_lsp.jsonls.setup{
    capabilities = capabilities,
}

nvim_lsp.vimls.setup{
    capabilities = capabilities,
}

nvim_lsp.tsserver.setup{
    capabilities = capabilities,
}

nvim_lsp.pyright.setup{
    capabilities = capabilities,
}

nvim_lsp.rust_analyzer.setup{
    capabilities = capabilities,
}

nvim_lsp.terraformls.setup{
    capabilities = capabilities
}

-- vim.ui.select = require("popui.ui-overrider")
local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.black,
        null_ls.builtins.diagnostics.mypy,
        null_ls.builtins.diagnostics.ruff,
    },
})

require'nvim-lightbulb'.update_lightbulb({
    sign = {
        enabled = true,
        priority = 10,
    },
    float = {
        enabled = false,
    },
    virtual_text = {
        enabled = true,
        hl_mode = "combine",
    },
    status_text = {
        enabled = true,
    }
})

vim.api.nvim_create_autocmd({'CursorHoldI', 'CursorHold'}, {
    pattern = '*',
    callback = function()
        require'nvim-lightbulb'.update_lightbulb()
    end,
})


local notify = require('notify')
vim.lsp.handlers['window/showMessage'] = function(_, result, ctx)
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    local lvl = ({
        'ERROR',
        'WARN',
        'INFO',
        'DEBUG',
    })[result.type]
    notify(result.message, lvl, {
        title = 'LSP | ' .. client.name,
        timeout = 10000,
        keep = function()
            return lvl == 'ERROR' or lvl == 'WARN'
        end,
    })
end

