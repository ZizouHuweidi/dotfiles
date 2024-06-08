return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
        "bash",
        "html",
        "json",
        "lua",
        "markdown",
        "regex",
        "c",
        "cpp",
        "zig",
        "java",
        "templ",
      },
    },
  },
}
