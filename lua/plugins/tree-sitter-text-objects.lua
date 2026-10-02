local ok, textobjects = pcall(require, "nvim-treesitter-textobjects")
if not ok then
  vim.schedule(function()
    vim.notify("Tree-sitter textobjects failed to load; run :Lazy sync and restart Neovim", vim.log.levels.ERROR)
  end)
  return
end

textobjects.setup({
  select = {
    lookahead = true,
    include_surrounding_whitespace = true,
  },
})

local select = require("nvim-treesitter-textobjects.select")

local function textobject(query)
  return function()
    select.select_textobject(query, "textobjects")
  end
end

vim.keymap.set({ "x", "o" }, "af", textobject("@function.outer"), { desc = "Select outer function" })
vim.keymap.set({ "x", "o" }, "if", textobject("@function.inner"), { desc = "Select inner function" })
vim.keymap.set({ "x", "o" }, "ac", textobject("@class.outer"), { desc = "Select outer class" })
vim.keymap.set({ "x", "o" }, "ic", textobject("@class.inner"), { desc = "Select inner class" })
