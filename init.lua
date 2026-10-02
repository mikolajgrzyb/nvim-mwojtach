if vim.fn.has("nvim-0.12") == 0 then
  error("This configuration requires Neovim 0.12 or newer")
end

require 'plugins'

require 'options'
require 'cmds'
require 'keymaps'

vim.cmd.colorscheme "retrobox"

require 'statusline'
require 'cursorline'
