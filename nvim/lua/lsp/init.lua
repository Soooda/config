local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
    print("lspconfig launch failed!")
end

require("lsp.lsp-installer")
require('lsp.handlers').setup()
