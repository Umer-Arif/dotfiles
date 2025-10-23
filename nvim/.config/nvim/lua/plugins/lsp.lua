-- Modern LSP Setup for Neovim 0.11+ with native vim.lsp.config
return {
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        opts = {
            ui = { border = "rounded" },
        },
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        opts = {
            ensure_installed = {
                "pyright",
                "clangd",
                "lua_ls",
                "rust_analyzer",
                "html",
                "cssls",
                "ts_ls",
            },
            automatic_installation = false,
        },
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = { "williamboman/mason-lspconfig.nvim" },
        config = function()
            -- Prepend Mason bin path so the right server is used
            vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH

            local on_attach = function(client, bufnr)
                -- disable formatting/signatureHelp if you want external tools
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.signatureHelpProvider = false

                vim.wo.number = true
                vim.wo.relativenumber = true

                local opts = { buffer = bufnr, noremap = true, silent = true }
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
                vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
            end

            -- Define server configurations
            local servers = {
                pyright = { on_attach = on_attach },
                lua_ls = {
                    on_attach = on_attach,
                    settings = {
                        Lua = {
                            runtime = { version = 'LuaJIT' },
                            diagnostics = { globals = { 'vim' } },
                            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
                            telemetry = { enable = false },
                        },
                    },
                },
                clangd = { on_attach = on_attach },
                rust_analyzer = {
                    on_attach = on_attach,
                    settings = {
                        ["rust-analyzer"] = {
                            checkOnSave = {
                                command = "check",
                            },
                            cargo = {
                                loadOutDirsFromCheck = true,
                                allFeatures = false,
                            },
                            procMacro = {
                                enable = true,
                            },
                            cachePriming = {
                                enable = false,
                            },
                            memoryLimit = 2048,
                        },
                    },
                },
                html = { on_attach = on_attach },
                cssls = { on_attach = on_attach },
            }

            -- Initialize nvim-lspconfig to make its configurations available
            require("lspconfig")

            -- Enable servers using the new native method
            for server_name, config in pairs(servers) do
                vim.lsp.config(server_name, config)
                vim.lsp.enable(server_name)
            end
        end,
    },
    -- ... rest of your plugins (typescript-tools.nvim, blink.cmp, etc.) remain the same
}
