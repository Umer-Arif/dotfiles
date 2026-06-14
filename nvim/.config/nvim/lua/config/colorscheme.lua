-- lua/plugins/colorscheme.lua
-- No plugin spec, just a Lua module
vim.defer_fn(function()
    vim.cmd [[colorscheme vscode]]
    vim.o.winblend = 0
    vim.o.pumblend = 0
end, 0)
