-- lua/plugins/colors/dracula.lua
return {
  "Mofiqul/dracula.nvim",
  name = "dracula",
  lazy = false,
  priority = 1000,
  config = function()
    require("dracula").setup({
      transparent_bg = false,
    })
  end,
}

