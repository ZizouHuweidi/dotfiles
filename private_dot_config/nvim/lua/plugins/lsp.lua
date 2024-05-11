return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- "angular-language-server",
        "templ",
        "zls"
      },
    },
  },


  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = {
          -- To fix lint errors.
          "ruff_fix",
          -- To run the Ruff formatter.
          "ruff_format",
        },
      },
    },
  }
}
