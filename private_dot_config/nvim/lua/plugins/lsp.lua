return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "gofumpt",
        "goimports",
      },
    },
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        go = {
          "goimports",
          "gofumpt",
        },
        php = {
          "php_cs_fixer",
        },
      },
    },
  },
}
