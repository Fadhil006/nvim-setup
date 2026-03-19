local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({
                "git",
                "clone",
                "--filter=blob:none",
                "https://github.com/folke/lazy.nvim.git",
                lazypath,
        })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

        -- ======================
        -- CompetiTest
        -- ======================
        {
                "xeluxee/competitest.nvim",
                dependencies = { "MunifTanjim/nui.nvim" },
                config = function()
                        require("competitest").setup({
                                received_problems_path =
                                        "/home/ash/CP/$(PROBLEM).$(FEXT)",
                                received_contests_directory =
                                        "/home/ash/CP",
                                received_contests_problems_path =
                                        "$(PROBLEM).$(FEXT)",
                                open_received_problems = true,
                                template_file = {
                                        cpp = vim.fn.expand("~/.config/nvim/templates/cpp.cpp"),
                                },
                        })
                end,
        },

        -- ======================
        -- Auto pairs
        -- ======================
        {
                "windwp/nvim-autopairs",
                config = function()
                        require("nvim-autopairs").setup({})
                end,
        },

        -- ======================
        -- File tree
        -- ======================
        {
                "nvim-tree/nvim-tree.lua",
                dependencies = { "nvim-tree/nvim-web-devicons" },
                config = function()
                        require("nvim-tree").setup({
                                sync_root_with_cwd = false,
                                respect_buf_cwd = false,
                                update_focused_file = {
                                        enable = true,
                                        update_root = false
                                },
                                view = {
                                        side = "left",
                                        width = 30,
                                },
                                filters = {
                                        dotfiles = true,
                                },
                        })
                end,
        },

        -- ======================
        -- Treesitter
        -- ======================
        {
                "nvim-treesitter/nvim-treesitter",
                build = ":TSUpdate",
                opts = {
                        ensure_installed = { "cpp", "c", "lua", "html", "css", "javascript", "typescript", "tsx", "json" },
                        highlight = { enable = true },
                },
        },

        -- ======================
        -- Snippets (LuaSnip)
        -- ======================
        {
                "L3MON4D3/LuaSnip",
                dependencies = { "rafamadriz/friendly-snippets" },
        },

        -- ======================
        -- Completion (nvim-cmp)
        -- ======================
        {
                "hrsh7th/nvim-cmp",
                dependencies = {
                        "hrsh7th/cmp-nvim-lsp",
                        "hrsh7th/cmp-buffer",
                        "hrsh7th/cmp-path",
                        "saadparwaiz1/cmp_luasnip",
                },
        },

        -- ======================
        -- Theme
        -- ======================
        {
                "catppuccin/nvim",
                name = "catppuccin",
                config = function()
                        require("catppuccin").setup({
                                transparent_background = true,
                        })
                        vim.cmd.colorscheme("catppuccin")
                end,
        },

        -- ======================
        -- Web Dev & LSPs
        -- ======================
        {
                "williamboman/mason.nvim",
                config = function()
                        require("mason").setup()
                end,
        },
        {
                "williamboman/mason-lspconfig.nvim",
                config = function()
                        require("mason-lspconfig").setup({
                                ensure_installed = { "ts_ls", "html", "cssls", "emmet_ls", "tailwindcss" },
                        })
                end,
        },
        {
                "neovim/nvim-lspconfig",
                config = function()
                        local capabilities = require("cmp_nvim_lsp").default_capabilities()
                        
                        -- Setup web dev LSPs
                        local servers = { "ts_ls", "html", "cssls", "emmet_ls", "tailwindcss" }
                        for _, lsp in ipairs(servers) do
                                -- Neovim 0.11 native lsp config API
                                vim.lsp.config[lsp] = {
                                        capabilities = capabilities,
                                }
                                vim.lsp.enable(lsp)
                        end
                end,
        },
        {
                "stevearc/conform.nvim",
                config = function()
                        require("conform").setup({
                                formatters_by_ft = {
                                        javascript = { "prettier" },
                                        typescript = { "prettier" },
                                        javascriptreact = { "prettier" },
                                        typescriptreact = { "prettier" },
                                        css = { "prettier" },
                                        html = { "prettier" },
                                        json = { "prettier" },
                                        markdown = { "prettier" },
                                },
                                format_on_save = {
                                        timeout_ms = 500,
                                        lsp_fallback = true,
                                },
                        })
                end,
        },

})

