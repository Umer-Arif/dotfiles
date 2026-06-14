-- lua/plugins/lualine.lua
return {
    "nvim-lualine/lualine.nvim",
    enabled = true,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require('lualine').setup {
            options = {
                icons_enabled = true,
                theme = 'auto',
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                always_show_tabline = true,
                globalstatus = false,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                    refresh_time = 16,
                    events = {
                        'WinEnter', 'BufEnter', 'BufWritePost', 'SessionLoadPost',
                        'FileChangedShellPost', 'VimResized', 'Filetype',
                        'CursorMoved', 'CursorMovedI', 'ModeChanged',
                    },
                }
            },
            sections = {
                lualine_a = {
                    {
                        'mode',
                        fmt = function(str)
                            return ' ' .. str
                        end,
                    }
                },
                lualine_b = { 'diff', 'diagnostics' },
                lualine_c = { { 'filename', path = 1 } },
                lualine_x = { 'filetype' },
                lualine_y = {
                    {
                        function() return vim.fn.line('$') end,
                        icon = '',
                    }
                },
                lualine_z = { 'location' }
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { 'filename' },
                lualine_x = { 'location' },
                lualine_y = {},
                lualine_z = {}
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {}
        }

        local function bold_lualine_a()
            local modes = { 'normal', 'insert', 'visual', 'command', 'replace', 'terminal', 'inactive' }
            for _, mode in ipairs(modes) do
                local hl_name = 'lualine_a_' .. mode
                local hl = vim.api.nvim_get_hl(0, { name = hl_name })
                if hl and next(hl) then
                    hl.bold = true
                    vim.api.nvim_set_hl(0, hl_name, hl)
                end
            end
        end

        bold_lualine_a()
        vim.api.nvim_create_autocmd('ColorScheme', {
            pattern = '*',
            callback = bold_lualine_a,
        })
    end,
}
