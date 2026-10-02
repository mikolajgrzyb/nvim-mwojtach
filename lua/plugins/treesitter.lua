local treesitter = require("nvim-treesitter")

treesitter.setup()

vim.filetype.add({
  pattern = {
    [".*%.blade%.php"] = "blade",
  },
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("treesitter-highlight", { clear = true }),
  pattern = {
    "lua",
    "vim",
    "help",
    "markdown",
    "html",
    "typescript",
    "typescriptreact",
    "javascript",
    "javascriptreact",
    "blade",
    "php",
  },
  callback = function()
    pcall(vim.treesitter.start)
  end,
})
