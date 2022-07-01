local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  return
end

local lspconfig = require("lspconfig")

local servers = {
  "jsonls",
  "sumneko_lua",
  "bashls",
  "dockerls",
  "tsserver",
  "pyright",
  "rust_analyzer"
}

lsp_installer.setup {
  ensure_installed = servers,
  automatic_installation = false,
  ui = {
    check_outdated_servers_on_open = true,
    icons = {
      server_installed = "",
      server_pending = "◍",
      server_uninstalled = ""
    }
  }
}

for _, server in pairs(servers) do
  local opts = {
    on_attach = require("jungin.lsp.handlers").on_attach,
    capabilities = require("jungin.lsp.handlers").capabilities,
  }
  local has_custom_opts, server_custom_opts = pcall(require, "jungin.lsp.settings." .. server)
  if has_custom_opts then
    opts = vim.tbl_deep_extend("force", server_custom_opts, opts)
  end
  if server == "rust_analyzer" then
    local lsp_opts = {
        -- on_attach is a callback called when the language server attachs to the buffer
        on_attach = require("jungin.lsp.handlers").on_attach,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {
                    command = "clippy"
                },
              }
          }
      }
    opts = vim.tbl_deep_extend("force", lsp_opts, opts)

    local rust_opts = {
      tools = { -- rust-tools options
        hover_with_actions = false,
        inlay_hints = {
          show_variable_name = true,
        }
      },

      -- all the opts to send to nvim-lspconfig
      -- these override the defaults set by rust-tools.nvim
      -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
      server = lsp_opts,
    }
    require('rust-tools').setup(rust_opts)

  else 
    lspconfig[server].setup(opts)
  end


end
