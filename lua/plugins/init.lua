local Lazy = {}

function Lazy.install(path)
  if not vim.loop.fs_stat(path) then
    print("Installing lazy.nvim....")
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      path,
    })
  end
end

function Lazy.load(p)
  local plugins = p or {}
  Lazy.install(Lazy.path)
  vim.opt.rtp:prepend(Lazy.path)
  require("lazy").setup(plugins, Lazy.opts)
end

Lazy.path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
Lazy.opts = {}

Lazy.load({
  -- BASE
  "nvim-lua/plenary.nvim",
  "nvim-tree/nvim-web-devicons",
  -- LSP
  "williamboman/mason-lspconfig.nvim",
  "williamboman/mason.nvim",
  "neovim/nvim-lspconfig",
  -- FORMATTERS
  "stevearc/conform.nvim",
  -- TELESCOPE
  { "nvim-telescope/telescope.nvim",            lazy = true },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true },
  "nvim-telescope/telescope-ui-select.nvim",
  -- TREESITTER
  "nvim-treesitter/nvim-treesitter",
  "nvim-treesitter/nvim-treesitter-context",
  {
    "nvzone/typr",
    dependencies = "nvzone/volt",
    opts = {},
    cmd = { "Typr", "TyprStats" },
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
      },
    },
    {
      "m4xshen/hardtime.nvim",
      lazy = false,
      dependencies = { "MunifTanjim/nui.nvim" },
    },
  },
  -- AUTOCOMPLETE
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/nvim-cmp",
  'hrsh7th/cmp-vsnip',
  'hrsh7th/vim-vsnip',
  {
    "chrisgrieser/nvim-scissors",
    dependencies = "nvim-telescope/telescope.nvim", -- if using telescope
    opts = {
      snippetDir = "~/.config/nvim/snippets",
    }
  },
  -- OIL
  "stevearc/oil.nvim",
  -- YAZI
  "mikavilpas/yazi.nvim",
  -- GIT
  -- {
  "kdheepak/lazygit.nvim",
  lazy = true,
  cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile",
  },
  "lewis6991/gitsigns.nvim",
  "sindrets/diffview.nvim",
  "NeogitOrg/neogit",
  -- UI
  "folke/which-key.nvim",
  -- BOOKMARS
  {
    'EvWilson/spelunk.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',           -- For window drawing utilities
      'nvim-telescope/telescope.nvim',   -- Optional: for fuzzy search capabilities
      'nvim-treesitter/nvim-treesitter', -- Optional: for showing grammar context
    },
    config = function()
      require('spelunk').setup({
        enable_persist = true
      })
    end
  },
  -- MISC
  "windwp/nvim-autopairs",
  "folke/todo-comments.nvim",
  "RRethy/vim-illuminate",
  "ggandor/leap.nvim",
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {
      dir = vim.fn.stdpath("state") .. "/sessions/",
      need = 1,
      branch = true,
    }
  },
  {
    "j-hui/fidget.nvim",
    tag = "v1.0.0", -- Make sure to update this to something recent!
    opts = {
      -- options
    },
  },
  -- THEME
  {
    "rmehri01/onenord.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "skardyy/makurai-nvim",
    lazy = false,
    priority = 1000,
  },
  { "dotsilas/darcubox-nvim", lazy = false, priority = 10000 },
  {
    "anuvyklack/windows.nvim",
    dependencies = {
      "anuvyklack/middleclass",
      "anuvyklack/animation.nvim"
    },
  },
  {
    "chentoast/marks.nvim",
    event = "VeryLazy",
  },
  {
    'vim-test/vim-test',
    dependencies = { 'tpope/vim-dispatch' }
  },
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
  }
})

require("windows").setup()
require "plugins.lspconfig"
require "plugins.mason"
require "plugins.telescope"
require "plugins.which-key"
require "plugins.treesitter"
require "plugins.tree-sitter-text-objects"
require "plugins.cmp"
require "plugins.conform"
require "plugins.marks"
require "plugins.hardtime"
require "plugins.fidget"
require "plugins.vsnip"

-- quick setup
require "gitsigns".setup()
require "nvim-autopairs".setup()
require "oil".setup()
require "leap".create_default_mappings()
require "yazi".setup({
  floating_window_scaling_factor = 1
})
require "illuminate".configure()
require "todo-comments".setup()
require "neogit".setup()
require "makurai".setup()

-- local
require "plugins.switchfiles"
