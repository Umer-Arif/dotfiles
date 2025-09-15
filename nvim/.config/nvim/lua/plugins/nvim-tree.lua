return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = true,
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- for file icons
  },
  config = function()
    require("nvim-tree").setup({
      update_focused_file = {
        enable = true,
        update_root = true,
      },
      respect_buf_cwd = true,
      sync_root_with_cwd = true,
    })
    vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<CR>', { desc = "Toggle NvimTree" })
  end,
}

