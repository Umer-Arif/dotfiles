return {
    "oxfist/night-owl.nvim",
    name = "night-owl",
    lazy = false,
    priority = 1000,
    config = function()
        require("night-owl").setup({
            transparent_background = true, -- ✅ correct key
            bold = true,
            italics = true,
            underline = true,
            undercurl = true,
        })
    end,
}
