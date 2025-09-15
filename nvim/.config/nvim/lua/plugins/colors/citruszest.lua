-- lua/plugins/colors/citruszest.lua
return {
    "zootedb0t/citruszest.nvim",
    name = "citruszest",
    lazy = false,
    priority = 1000,
    config = function()
        require("citruszest").setup({
            option = {
                transparent = true,
            },
        })
    end,
}
