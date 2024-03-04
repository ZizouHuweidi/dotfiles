return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    enabled = false,
    opts = {
      flavour = "mocha", -- latte, frappe, macchiato, mocha
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
}
