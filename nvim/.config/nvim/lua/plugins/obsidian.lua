return {
    {
        "obsidian-nvim/obsidian.nvim",
        version = "*", -- latest
        event = {
            "BufReadPre ~/Documents/Obsidian Vault/**.md",
            "BufNewFile ~/Documents/Obsidian Vault/**.md",
            "BufReadPre ~/Documents/Vu uni/**.md",
            "BufNewFile ~/Documents/Vu uni/**.md",
        },
        opts = {
            workspaces = {
                {
                    name = "personal",
                    path = "~/Documents/Obsidian Vault",
                },
                {
                    name = "vu",
                    path = "~/Documents/Vu uni",
                },
            },
            completion = {
                nvim_cmp = true,
            },
        },
    },
}
