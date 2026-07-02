require("hardtime").setup({
  restricted_keys = {
    ["j"] = {},
    ["k"] = {},
    ["h"] = {},
    ["l"] = {},
  },
  disabled_keys = {
    ["<Right>"] = { "n", "x" },
    ["<Up>"] = { "n", "x" },
    ["<Down>"] = { "n", "x" },
    ["<Left>"] = { "n", "x" }
  }
})
