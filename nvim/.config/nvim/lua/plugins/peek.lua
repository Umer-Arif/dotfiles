return {
    "toppair/peek.nvim",
    build = "deno task --quiet build:fast",
    ft = "markdown", -- lazy-load on markdown files
    config = function()
        require("peek").setup({
            auto_load = true,
            close_on_bdelete = true,
            syntax = true,
            theme = "dark",
        })

        -- explicitly create commands
        vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
        vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})
    end,
}
