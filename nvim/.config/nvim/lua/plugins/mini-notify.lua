return {
    "echasnovski/mini.notify",
    version = false,
    config = function()
        require("mini.notify").setup({
            -- Optional custom settings
            window = {
                config = { border = "rounded" },
                winblend = 15,
            },
        })

        -- 👇 Set it as the default notify backend
        vim.notify = require("mini.notify").make_notify()
    end,
}
