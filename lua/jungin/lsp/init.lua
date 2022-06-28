local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "jungin.lsp.configs"
require("jungin.lsp.handlers").setup()
