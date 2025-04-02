local wk = require 'which-key'

wk.setup({
  preset = 'helix',
  win = {
    padding = { 1, 3 },
    wo = {
      winblend = 0,
    },
  }
})

vim.api.nvim_set_hl(0, "WhichKey", { bg = "#15161B" })
vim.api.nvim_set_hl(0, "WhichKeyBorder", { bg = "#15161B" })
vim.api.nvim_set_hl(0, "WhichKeyDesc", { bg = "#15161B" })
vim.api.nvim_set_hl(0, "WhichKeyGroup", { bg = "#15161B" })
vim.api.nvim_set_hl(0, "WhichKeyNormal", { bg = "#15161B" })
vim.api.nvim_set_hl(0, "WhichKeySeparator", { bg = "#15161B" })
vim.api.nvim_set_hl(0, "WhichKeyValue", { bg = "#15161B" })
