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
  lspconfig[server].setup(opts)
end
