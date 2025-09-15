-- lua/plugins/colors/citruszest.lua
return {
    "rebelot/kanagawa.nvim",
    name = "kanagawa",
    lazy = false,
    priority = 1000,
    config = function()
        require("kanagawa").setup({
            option = {
                transparent = true,
            },
        })
    end,
}
