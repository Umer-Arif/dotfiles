-- ~/.config/nvim/lua/plugins/indent.lua
return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl", -- this is important for lazy.nvim to load the correct module
    opts = {
        indent = {
            char = "│",
            tab_char = "│",
        },
        scope = {
            enabled = true,
            show_start = false,
            show_end = false,
            highlight = "IblScope",
        },
        exclude = {
            filetypes = {
                "help", "terminal", "lazy", "mason", "NvimTree", "neo-tree",
                "Trouble", "toggleterm", "checkhealth", "lspinfo",
                "DressingInput", "dap-repl", "TelescopePrompt", "TelescopeResults",
            },
            buftypes = { "nofile", "prompt", "quickfix" },
        },
    },
}
