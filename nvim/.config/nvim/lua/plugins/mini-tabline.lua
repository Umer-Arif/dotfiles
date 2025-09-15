return {
    "echasnovski/mini.tabline",
    version = false,
    lazy = false,
    config = function()
        require("mini.tabline").setup({
            show_icons = true,        -- Set false if you want minimal style
            set_vim_settings = false, -- Set to true if you want `showtabline = 2`
        })
    end,
}
