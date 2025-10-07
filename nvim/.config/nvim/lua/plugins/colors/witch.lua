return {
    "sontungexpt/witch",
    name = "witch",
    lazy = false,
    priority = 1000,
    config = function()
        require("witch").setup({
            transparent = true, -- ✅ works fine
            glow = false,       -- optional
        })
    end,
}
