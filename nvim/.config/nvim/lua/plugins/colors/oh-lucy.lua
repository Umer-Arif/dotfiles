-- lua/plugins/colors/citruszest.lua
return {
    "Yazeed1s/oh-lucy.nvim",
    name = "oh-lucy",
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
