return {
    "shaunsingh/moonlight.nvim",
    name = "moonlight",
    lazy = false,
    priority = 1000,
    config = function()
        -- Set global variables inside the config block
        vim.g.moonlight_italic_comments = true
        vim.g.moonlight_italic_keywords = true
        vim.g.moonlight_italic_functions = true
        vim.g.moonlight_italic_variables = false
        vim.g.moonlight_contrast = true
        vim.g.moonlight_borders = false
        vim.g.moonlight_disable_background = true

        -- Set the colorscheme
        require("moonlight").set()
    end,
}
