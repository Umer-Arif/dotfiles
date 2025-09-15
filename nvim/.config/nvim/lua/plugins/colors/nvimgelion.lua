return {
    'nyngwang/nvimgelion',
    name = "nvimgelion",
    lazy = false,
    priority = 1000,
    config = function()
        -- Example: make Normal background transparent
        vim.cmd [[
      hi Normal guibg=NONE ctermbg=NONE
      hi NormalFloat guibg=NONE ctermbg=NONE
    ]]
    end,
}
