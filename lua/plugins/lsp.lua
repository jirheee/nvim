return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              rustc = {
                source = "discover",
              },
            },
          },
        },
      },
    },
  },
}
