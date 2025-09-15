return {
    "echasnovski/mini.statusline",
    enabled = false,
    version = false,
    lazy = false,
    config = function()
        require("mini.statusline").setup({
            use_icons = true, -- Ensure this is set to true for icon support!
            set_vim_settings = true,
            content = {
                active = function()
                    local mode_map = {
                        n = { label = "NORMAL", hl = "MiniStatuslineModeNormal" },
                        i = { label = "INSERT", hl = "MiniStatuslineModeInsert" },
                        v = { label = "VISUAL", hl = "MiniStatuslineModeVisual" },
                        V = { label = "V-LINE", hl = "MiniStatuslineModeVisual" },
                        ["\22"] = { label = "V-BLOCK", hl = "MiniStatuslineModeVisual" },
                        c = { label = "COMMAND", hl = "MiniStatuslineModeCommand" },
                        R = { label = "REPLACE", hl = "MiniStatuslineModeReplace" },
                        s = { label = "SELECT", hl = "MiniStatuslineModeVisual" },
                        S = { label = "S-LINE", hl = "MiniStatuslineModeVisual" },
                        ["\19"] = { label = "S-BLOCK", hl = "MiniStatuslineModeVisual" },
                        r = { label = "REPLACE-ONE", hl = "MiniStatuslineModeReplace" },
                        t = { label = "TERMINAL", hl = "MiniStatuslineModeOther" },
                    }
                    local mode = vim.fn.mode()
                    local mode_info = mode_map[mode] or { label = mode, hl = "MiniStatuslineModeOther" }

                    -- Sections to display
                    local git = MiniStatusline.section_git({ trunc_width = 40 })
                    local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
                    local filename = MiniStatusline.section_filename({ trunc_width = 140 })

                    -- --- Custom Location and Filetype Format ---
                    -- Get current line number
                    local current_line = vim.fn.line('.')
                    -- Get total lines in the buffer
                    local total_lines = vim.fn.line('$')
                    -- Format as "current_line:total_lines" (e.g., "7:43")
                    local line_total_str = string.format("%d:%d", current_line, total_lines)

                    -- --- Get Filetype Icon and Text ---
                    local filetype_icon = ''
                    local filetype_text = vim.bo.filetype ~= '' and vim.bo.filetype or '[No Filetype]'

                    -- Check if nvim-web-devicons is loaded and has the get_icon function
                    if pcall(require, 'nvim-web-devicons') and require('nvim-web-devicons').get_icon then
                        -- Get the icon for the current file (using current filename and filetype)
                        filetype_icon = require('nvim-web-devicons').get_icon(vim.fn.expand('%:t'), filetype_text) or ''
                    end

                    -- Combine icon and text for display
                    -- Add a space between icon and text if icon exists
                    local filetype_display = filetype_icon .. (filetype_icon ~= '' and ' ' or '') .. filetype_text

                    -- Combine filetype and location with a separator
                    local filetype_and_location = string.format("%s | %s", filetype_display, line_total_str)


                    return MiniStatusline.combine_groups({
                        -- Left side of statusline
                        { hl = mode_info.hl,            strings = { mode_info.label } },
                        { hl = "MiniStatuslineDevinfo", strings = { git, diagnostics } },
                        "%<", -- Truncate here if window is too narrow

                        -- Middle (filename)
                        { hl = "MiniStatuslineFilename", strings = { filename } },

                        "%=", -- Align subsequent sections to the right

                        -- Right side (Filetype Icon + Text | current_line:total_lines)
                        { hl = "MiniStatuslineFileinfo", strings = { filetype_and_location } },
                    })
                end,
            },
        })

        -- Define a universal fallback highlight group for "bad" colorschemes
        vim.api.nvim_set_hl(0, "MiniStatuslineModeFallback", { fg = "#011627", bg = "#00BFFF", bold = true }) -- Example: Dark text on Deep Sky Blue background

        -- Function to set custom mode highlights for specific themes
        local function set_custom_nightowl_mode_highlights()
            -- Link all MiniStatuslineMode* groups to your single fallback highlight
            vim.api.nvim_set_hl(0, "MiniStatuslineModeNormal", { fg = "#000000", bg = "#C792EA", bold = true })
            vim.api.nvim_set_hl(0, "MiniStatuslineModeInsert", { link = "MiniStatuslineModeFallback" })
            vim.api.nvim_set_hl(0, "MiniStatuslineModeVisual", { fg = "#000000", bg = "#cf6d53", bold = true })
            vim.api.nvim_set_hl(0, "MiniStatuslineModeReplace", { link = "MiniStatuslineModeFallback" })
            vim.api.nvim_set_hl(0, "MiniStatuslineModeCommand", { link = "MiniStatuslineModeFallback" })
            vim.api.nvim_set_hl(0, "MiniStatuslineModeOther", { link = "MiniStatuslineModeFallback" })
        end

        -- Create an Autocmd to apply custom highlights when Night Owl is loaded
        vim.api.nvim_create_autocmd("ColorScheme", {
            pattern = "night-owl",
            group = vim.api.nvim_create_augroup("MiniStatuslineNightOwlOverrides", { clear = true }),
            callback = set_custom_nightowl_mode_highlights,
        })

        -- IMPORTANT: Also call `set_custom_nightowl_mode_highlights` on startup
        if vim.g.colors_name == "night-owl" then
            set_custom_nightowl_mode_highlights()
        end
    end, -- Closes the config function
}
