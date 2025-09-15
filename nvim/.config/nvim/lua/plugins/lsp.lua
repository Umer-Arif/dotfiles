-- Modular LSP and Completion Setup with blink.cmp and nvim-autopairs

return {
    -- Mason (LSP installer)
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        opts = {
            ui = { border = "rounded" },
        },
    },

    -- Mason integration with lspconfig
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",
        },
        opts = {
            ensure_installed = {
                "pyright",
                "clangd",
                "lua_ls",
            },
            automatic_installation = false,
        },
    },

    -- Core LSP config
    {
        "neovim/nvim-lspconfig",
        dependencies = { "williamboman/mason-lspconfig.nvim" },
        config = function()
            local lspconfig = require("lspconfig")

            local on_attach = function(client, bufnr)
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.signatureHelpProvider = false
                vim.wo.number = true
                vim.wo.relativenumber = true
            end

            -- Optional: disable ts_ls autostart if you're using typescript-tools
            lspconfig.ts_ls.setup({ autostart = false })

            local servers = {
                python = "pyright",
                lua = "lua_ls",
                c = "clangd",
                cpp = "clangd",
                html = "html",
                css = "cssls",
            }

            vim.api.nvim_create_autocmd("FileType", {
                pattern = vim.tbl_keys(servers),
                callback = function(args)
                    local ft = args.match
                    local server = servers[ft]
                    if server and not lspconfig[server].manager then
                        lspconfig[server].setup({
                            on_attach = on_attach,
                        })
                    end
                end,
            })
        end,
    },

    -- typescript-tools: override tsserver completely
    {
        "pmizio/typescript-tools.nvim",
        ft = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "neovim/nvim-lspconfig",
        },
        init = function()
            vim.api.nvim_create_autocmd("User", {
                pattern = "MasonPackageInstalling",
                callback = function(args)
                    if args.data.package == "typescript-language-server" then
                        vim.notify("BLOCKED: tsserver is handled by typescript-tools.nvim", vim.log.levels.WARN)
                        vim.cmd("MasonUninstall typescript-language-server")
                    end
                end,
            })
        end,
        opts = function()
            local util = require("lspconfig").util
            return {
                root_dir = util.root_pattern(
                    ".git",
                    "tsconfig.json",
                    "jsconfig.json",
                    "package.json"
                ),
                tsserver_options = {
                    args = { "--max-old-space-size=4096" },
                },
                settings = {
                    exclude = {
                        "**/node_modules",
                        "**/dist",
                        "**/build",
                        "**/.git",
                        "**/.vscode",
                        "**/*.test.*",
                    },
                    separate_diagnostic_server = false,
                    publish_diagnostic_on = "insert_leave",
                    expose_as_code_action = {
                        "fix_all",
                        "add_missing_imports",
                        "remove_unused",
                    },
                    tsserver_file_preferences = {
                        includeInlayParameterNameHints = "none",
                        includeInlayFunctionParameterTypeHints = false,
                    },
                },
                on_attach = function(client, bufnr)
                    client.server_capabilities.documentFormattingProvider = false
                    client.server_capabilities.signatureHelpProvider = false
                    vim.wo.number = true
                    vim.wo.relativenumber = true
                end,
            }
        end,
    },

    -- blink.cmp completion engine
    {
        "saghen/blink.cmp",
        dependencies = { "rafamadriz/friendly-snippets" },
        version = "1.*",
        event = "InsertEnter",
        opts = {
            keymap = {
                preset = "default",
                completion = {
                    ["<CR>"] = "confirm_if_selected_then_nop",
                },
            },
            appearance = { nerd_font_variant = "mono" },
            completion = {
                documentation = { auto_show = false },
                list = {
                    selection = {
                        preselect = false,
                        auto_insert = true,
                    },
                },
            },
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
            },
            fuzzy = { implementation = "prefer_rust_with_warning" },
        },
        opts_extend = { "sources.default" },
    },

    -- nvim-autopairs for automatic bracket, quote pairing
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter", -- Load only when entering insert mode
        opts = {},             -- Empty opts table means default configuration
        config = function()
            require("nvim-autopairs").setup({
                -- You can add custom rules or disable specific ones here if needed.
                -- For instance, to disable specific chars:
                -- disable_filetype = { "TelescopePrompt", "vim" },
                -- map_bs = true, -- map backspace to delete the pair
                -- map_cr = true, -- map enter to close the pair (this might interact with cmp, usually leave as default)
            })
        end
    },

    -- Formatter (with fix for Oil)
    {
        "stevearc/conform.nvim",
        event = "BufWritePre",
        opts = {
            format_on_save = function(bufnr)
                if vim.bo[bufnr].filetype == "oil" then
                    return
                end
                return { timeout_ms = 500, lsp_fallback = true }
            end,
            formatters_by_ft = {
                javascript = { "prettier" },
                lua = { "stylua" },
                python = { "black" },
                html = { "prettier" },
                css = { "prettier" },
            },
        },
    },
}
