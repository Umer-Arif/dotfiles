-- ~/.config/nvim/lua/plugins/oil.lua

return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        default_file_explorer = true,
        view_options = {
            show_hidden = true,
        },
        float = {
            padding = 2,
            max_width = 0,
            max_height = 0,
            border = "rounded",
            win_options = {
                winblend = 0,
            },
        },
    },
    keys = {
        {
            "<leader>of",
            function()
                require("oil").open(vim.fn.getcwd())
            end,
            desc = "Oil: Open Current Working Directory",
        },
        {
            "<leader>o",
            function()
                local path = vim.fn.expand("%:p:h")
                require("oil").open_float(path)
            end,
            desc = "Oil: Open Parent Directory of Current File",
        },
        {
            "<leader>oq",
            function()
                require("oil").close()
            end,
            desc = "Oil: Close",
        },
    },
    cmd = { "Oil" },
}
