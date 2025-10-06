require("hardtime").setup({
  restricted_keys = {
    ["j"] = {},
    ["k"] = {},
  },
  disabled_keys = {
    ["<Right>"] = { "n", "x" },
    ["<Up>"] = { "n", "x" },
    ["<Down>"] = { "n", "x" },
    ["<Left>"] = { "n", "x" }
  }
})
