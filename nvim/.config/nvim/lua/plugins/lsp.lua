return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "pyright", -- python
        "ruff", -- python lint/format-capable LSP
        "ts_ls", -- typescript/javascript
        "bashls", -- bash
        "dockerls", -- dockerfile
        "docker_compose_language_service",
        "yamlls", -- yaml
        "lua_ls", -- lua (also used for editing this config)
        "rust_analyzer", -- rust
        "jdtls", -- java (basic setup; consider nvim-jdtls for advanced Java workflows)
        "jsonls", -- json
        "taplo", -- toml
      },
      automatic_installation = true,
    },
  },
  {
    -- Installs the non-LSP CLI tools that conform.lua / lint.lua expect
    -- (formatters, linters) via Mason, alongside the LSP servers above.
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "stylua",
        "shfmt",
        "shellcheck",
        "prettier",
        "ruff", -- doubles as formatter (ruff_format) and linter
        "eslint_d",
        "hadolint",
        "yamllint",
        "taplo",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp_keymaps", { clear = true }),
        callback = function(event)
          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = event.buf, desc = desc })
          end
          map("n", "gd", vim.lsp.buf.definition, "Goto definition")
          map("n", "gD", vim.lsp.buf.declaration, "Goto declaration")
          map("n", "gr", vim.lsp.buf.references, "Goto references")
          map("n", "gI", vim.lsp.buf.implementation, "Goto implementation")
          map("n", "K", vim.lsp.buf.hover, "Hover docs")
          map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
          map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
          map("n", "<leader>d", vim.diagnostic.open_float, "Line diagnostics")
          map("n", "[d", vim.diagnostic.goto_prev, "Prev diagnostic")
          map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
        end,
      })

      -- nvim-lspconfig's `require("lspconfig")[server].setup()` API is
      -- deprecated (removed in v3.0.0). The current API: nvim-lspconfig
      -- ships default configs under its `lsp/` runtime dir, and loading
      -- the plugin registers them; `vim.lsp.config()` overrides/extends a
      -- named config, `vim.lsp.enable()` turns on autostart for it.
      vim.lsp.config("*", { capabilities = capabilities })

      local servers = {
        "pyright",
        "ruff",
        "ts_ls",
        "bashls",
        "dockerls",
        "docker_compose_language_service",
        "yamlls",
        "rust_analyzer",
        "jdtls",
        "jsonls",
        "taplo",
      }
      vim.lsp.enable(servers)

      -- lua_ls needs extra settings so it knows about the Neovim runtime
      -- (otherwise it flags `vim` as an undefined global everywhere).
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      })
      vim.lsp.enable("lua_ls")

      vim.diagnostic.config({
        virtual_text = true,
        severity_sort = true,
        float = { border = "rounded" },
      })
    end,
  },
}
