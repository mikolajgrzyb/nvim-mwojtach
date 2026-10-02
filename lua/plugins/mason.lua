require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",
    "vtsls",
    "intelephense",
    "emmet_language_server",
    "cssls",
    "angularls",
  },
  -- Servers are enabled explicitly in plugins.lspconfig after their local
  -- configuration has been applied.
  automatic_enable = false,
})
