-- lua/plugins/colors/dark_flat.lua
return {
    "sekke276/dark_flat.nvim",
    name = "dark_flat",
    lazy = false,
    priority = 1000,
    config = function()
        require("dark_flat").setup({
            transparent = false,
            colors = {},
            themes = function(colors)
                return {}
            end,
            italics = true,
        })
    end,
}
