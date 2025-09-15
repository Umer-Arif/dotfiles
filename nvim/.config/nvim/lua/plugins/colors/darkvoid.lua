return {
    "aliqyan-21/darkvoid.nvim",
    name = "darkvoid",
    lazy = false,
    priority = 1000,
    config = function()
        require("darkvoid").setup({
            transparent = true, -- ✅ no "option = {}"
            glow = false,       -- optional, add if needed
        })
    end,
}