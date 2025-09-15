-- lua/plugins/noice.lua (assuming this file is for noice.nvim)
return {
  -- This is the start of the plugin definition table for "folke/noice.nvim"
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    -- The 'opts' table should be part of the plugin definition
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
    },
    -- THIS 'config' FUNCTION MUST BE INSIDE THE PLUGIN'S TABLE
    config = function()
      require("noice").setup({
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
      })
    end, -- Make sure this 'end' matches the 'config = function()'
  }, -- This '}' closes the plugin definition table for "folke/noice.nvim"
} -- This '}' closes the outer 'return {}' table
