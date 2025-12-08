return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "jdtls", -- Java
        "pyright", -- Python
        "typescript-language-server", -- JS/TS
        "bash-language-server", -- Bash
        "lua-language-server", -- Lua
        "json-lsp", -- JSON
        "yaml-language-server", -- YAML
        "docker-compose-language-service",
        "dockerfile-language-server",
        "html-lsp",
        "css-lsp",
        "tailwindcss-language-server",
        "gopls", -- Go
        "clangd", -- C/C++
        "cmake-language-server",
        "marksman", -- Markdown
        "sqlls", -- SQL

        -- Formatters
        "google-java-format",
        "black",
        "prettier",
        "shfmt",
        "stylua",
        "gofumpt",
        "clang-format",

        -- Linters
        "eslint-lsp",
        "shellcheck",
      },
    },
  },
}
