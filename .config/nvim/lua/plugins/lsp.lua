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
