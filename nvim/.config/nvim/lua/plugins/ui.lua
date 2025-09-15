-- ~/.config/nvim/lua/plugins/ui.lua
return {
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        cmd = "TroubleToggle",
        keys = {
            { "<leader>xx", "<cmd>TroubleToggle<cr>",                       desc = "Toggle Trouble" },
            { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics" },
            { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",  desc = "Document Diagnostics" },
            { "<leader>xl", "<cmd>TroubleToggle loclist<cr>",               desc = "Location List" },
            { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",              desc = "Quickfix List" },
        },
        opts = {},
    },
}
