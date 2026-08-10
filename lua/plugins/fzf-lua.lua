require "fzf-lua".setup {
  "border-fused",
  keymap = {
    fzf = {
      ["alt-a"] = "select-all+accept"
    }
  },
  defaults = {
    formatter = { "path.filename_first", 999 }
  },
  winopts = {
    backdrop = 100,
    fullscreen = true,
  },
  fzf_colors = {
    ["gutter"] = "-1",
  }
}
