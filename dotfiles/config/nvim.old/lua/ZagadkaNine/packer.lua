local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()


return require('packer').startup(function(use)
    use("wbthomason/packer.nvim")
    use ('ojroques/nvim-hardline')
    -- use("sbdchd/neoformat")
    -- use("TimUntersberger/neogit")

    use("nvim-lua/plenary.nvim")
    use("nvim-lua/popup.nvim")
    use("nvim-telescope/telescope.nvim")
    use("williamboman/mason.nvim")
    use("williamboman/mason-lspconfig.nvim")
    -- LSP
    use("neovim/nvim-lspconfig")
    -- use("hrsh7th/nvim-cmp")
    -- use("hrsh7th/cmp-nvim-lsp")
    -- use("williamboman/nvim-lsp-installer")




    -- use("onsails/lspkind-nvim")
    -- use("nvim-lua/lsp_extensions.nvim")


    -- use("hrsh7th/cmp-nvim-lua")
    -- use("hrsh7th/cmp-buffer")
    -- use("hrsh7th/cmp-path")
    -- use("hrsh7th/cmp-cmdline")
    -- use("saadparwaiz1/cmp_luasnip")

    -- use("mfussenegger/nvim-dap")
    -- use("jose-elias-alvarez/null-ls.nvim")

    -- use("simrat39/symbols-outline.nvim")
    -- use("L3MON4D3/LuaSnip")
    -- use("tpope/vim-fugitive")
    -- use("tpope/vim-surround")
    use("tpope/vim-commentary")

    -- use("hood/popui.nvim")
    -- use("RishabhRD/popfix")
    -- use("kosayoda/nvim-lightbulb")
    -- use("folke/lsp-colors.nvim")
    -- use("folke/trouble.nvim")
    -- use("https://git.sr.ht/~whynothugo/lsp_lines.nvim")
    -- use("ray-x/lsp_signature.nvim")

    use("catppuccin/nvim")

    use({
        'kyazdani42/nvim-tree.lua',
        requires = { 'kyazdani42/nvim-web-devicons'},
        tag = 'nightly' -- optional, updated every week. (see issue #1193)
    })

    use("rcarriga/nvim-notify")

    use("ThePrimeagen/harpoon")

    -- use("folke/neodev.nvim")
    -- use("simrat39/rust-tools.nvim")
    -- use("hashivim/vim-terraform")

    -- use("lilydjwg/colorizer")
    -- use("nyoom-engineering/oxocarbon.nvim")

    -- use("nvim-treesitter/nvim-treesitter", {
    --     run = ":TSUpdate"
    -- })

    --use({
    --    "glepnir/lspsaga.nvim",
    --    opt = true,
    --    branch = "main",
    --    event = "LspAttach",
    --    config = function()
    --        require("lspsaga").setup({})
    --    end,
    --    requires = {
    --        {"nvim-tree/nvim-web-devicons"},
    --        --Please make sure you install markdown and markdown_inline parser
    --        {"nvim-treesitter/nvim-treesitter"}
    --    }
    --})
    use("github/copilot.vim")


    -- use("pearofducks/ansible-vim")

    if packer_bootstrap then
        require('packer').sync()
    end
end)
