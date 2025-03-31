require "conform".setup({
  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },
  notify_no_formatters = true,
  notify_on_error = true,
  formatters_by_ft = {
    lua = { "stylua" },
    markdown = { "markdownlint" },
    json = { "jsonlint", "prettierd" },
    dockerfile = { "hadolint" },
    javascript = { "prettierd" },
    typescript = { "prettierd" },
    go = { "golines", "goimports", "golangci", "golangci_lint_ls", "golangci-lint" },
    html = { "htmlbeautifier", "htmlhint" },
    tmpl = { "htmlbeautifier", "htmlhint" },
    php = { "pint", "php_cs_fixer" }
  },
})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("EslintFixAll", { clear = true }),
  pattern = { "*.tsx", "*.ts", "*.jsx", "*.js" },
  command = "silent! EslintFixAll",
})
