return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, "js-debug-adapter")
    end,
  },

  -- PRETTIER
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "prettier" } },
  },

  -- TAILWINDCSS
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, "tailwindcss-language-server")
    end,
  },
}
