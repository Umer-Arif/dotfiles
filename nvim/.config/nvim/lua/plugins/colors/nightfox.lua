-- lua/plugins/colors/palenight.lua
return {
    "EdenEast/nightfox.nvim", -- palenight is part of nightfox collection
    name = "palenight",
    lazy = false,
    priority = 1000,
    config = function()
        require('nightfox').setup({
            options = {
                -- Some terminals don't display italics very well,
                -- thus, they're disabled by default.
                italic = false,

                -- Fallback color palette for non-truecolor terminals,
                -- such as tty or some really old terminal.
                --
                -- Available options:
                -- "auto" => 16 color palette if in linux tty, 256 otherwise.
                -- 256    => 256 color palette.
                -- 16     => 16 color palette.
                cterm_palette = "auto",

                -- Transparent background
                transparent = true,
            }
        })
    end,
}
