-- lua/plugins/colorscheme.lua
-- No plugin spec, just a Lua module
vim.defer_fn(function()
    vim.cmd [[colorscheme WinterIsComing-dark-blue-color-theme]]
end, 50)
