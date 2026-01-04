return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      -- emmet_ls = {
      --   filetypes = {
      --     "css",
      --     "eruby",
      --     "html",
      --     "less",
      --     "sass",
      --     "scss",
      --     "pug",
      --   },
      -- },
      marksman = {
        filetypes = {
          "md",
        },
      },
      eslint = {
        settings = {
          useFlatConfig = true,
          experimental = {
            useFlatConfig = nil,
          },
        },
      },
    },
  },
}
