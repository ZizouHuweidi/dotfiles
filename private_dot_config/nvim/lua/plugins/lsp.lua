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
    "nvimtools/none-ls.nvim",
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, { "gomodifytags", "impl" })
        end,
      },
    },
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = vim.list_extend(opts.sources or {}, {
        nls.builtins.code_actions.gomodifytags,
        nls.builtins.code_actions.impl,
        nls.builtins.formatting.goimports,
        nls.builtins.formatting.gofumpt,
      })
    end,
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = {
          "ruff_fix",
          "ruff_format",
        },
        go = {
          "goimports",
          "gofumpt",
        },
      },
    },
  },
}
