return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPre", "BufNewFile" }, -- Lazy load on buffer read instead of startup
  config = function()
    require("nvim-treesitter.configs").setup({
      highlight = { enable = true },
      indent = { enable = true },
      auto_install = true, -- Automatically install parsers for new filetypes
      ensure_installed = {
        "lua", 
        "c", 
        "python", 
        "css", 
        "html", 
        "javascript", 
        "bash",
        "vimdoc", -- Added: help file highlighting
        "query",  -- Added: for treesitter queries
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    })
  end,
}
