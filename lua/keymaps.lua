local utils_diagnostics = require "plugins.diagnostics"

local telescope = require "telescope.builtin"
local wk = require("which-key")
local gitsigns = require "gitsigns"

local default_opts = { noremap = true, silent = true }
local kset = vim.keymap.set

local function opts(extends)
  local tbl = extends or {}
  return vim.tbl_deep_extend('force', tbl, default_opts)
end

kset("n", "<leader>sn", "<cmd>noautocmd w <CR>", opts({ desc = "Save without formatting" }))

kset("n", "x", '"_x', default_opts)

kset("v", "<", "<gv", default_opts)
kset("v", ">", ">gv", default_opts)

kset("n", "<C-d>", "<C-d>zz", opts({ desc = "Scroll down and center" }))
kset("n", "<C-u>", "<C-u>zz", opts({ desc = "Scroll up and center" }))

kset("n", "n", "nzzzv", opts({ desc = "Find next and center" }))
kset("n", "N", "Nzzzv", opts({ desc = "Find previous and center" }))

kset("n", "<Up>", ":resize +15<CR>", opts({ desc = "Increase window height" }))
kset("n", "<Down>", ":resize -15<CR>", opts({ desc = "Decrease window height" }))
kset("n", "<Left>", ":vertical resize -15<CR>", opts({ desc = "Decrease window width" }))
kset("n", "<Right>", ":vertical resize +15<CR>", opts({ desc = "Increase window width" }))

kset("n", "<Tab>", ":bnext<CR>", opts({ desc = "Next buffer" }))
kset("n", "<S-Tab>", ":bprevious<CR>", opts({ desc = "Previous buffer" }))
kset("n", "<leader>bd", ":bdelete<CR>", opts({ desc = "Delete buffer" }))
kset("n", "<leader>bo", ":%bd|e#<CR>", opts({ desc = "Delete other buffers" }))

kset("n", "<leader>wv", "<C-w>v", opts({ desc = "Split window vertically" }))
kset("n", "<leader>wh", "<C-w>s", opts({ desc = "Split window horizontally" }))
kset("n", "<leader>wq", ":close<CR>", opts({ desc = "Close window" }))

kset("n", "<C-k>", ":wincmd k<CR>", opts({ desc = "Go to split up" }))
kset("n", "<C-j>", ":wincmd j<CR>", opts({ desc = "Go to split down" }))
kset("n", "<C-h>", ":wincmd h<CR>", opts({ desc = "Go to split left" }))
kset("n", "<C-l>", ":wincmd l<CR>", opts({ desc = "Go to split right" }))

kset("v", "p", '"_dP', opts({ desc = "Keep last yanked when pasting" }))

kset("n", "<S-A-j>", "<cmd>execute 'move .+' . v:count1<CR>==", opts({ desc = "Move Down" }))
kset("n", "<S-A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<CR>==", opts({ desc = "Move Up" }))
kset("i", "<S-A-j>", "<esc><cmd>m .+1<CR>==gi", opts({ desc = "Move Down" }))
kset("i", "<S-A-k>", "<esc><cmd>m .-2<CR>==gi", opts({ desc = "Move Up" }))
kset("v", "<S-A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<CR>gv=gv", opts({ desc = "Move Down" }))
kset("v", "<S-A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<CR>gv=gv", opts({ desc = "Move Up" }))

kset("n", "<leader>n", "<cmd>messages<CR>", opts({ desc = "Show messages" }))

kset("n", "<leader>cf", function() vim.lsp.buf.format() end, opts({ desc = "Format file" }))

kset("n", "<S-Down>", function() Switchfiles.select() end, opts({ desc = "Select similar file" }))
kset("n", "<S-Right", function() Switchfiles.switch() end, opts({ desc = "Switch to similar file" }))

-- OIL
kset("n", "-", "<CMD>Oil<CR>", opts({ desc = "Open parent directory" }))

-- TELESCOPE
kset("n", "<leader>f", "<cmd>Telescope find_files<CR>", opts({ desc = "Find files" }))
kset("n", "<leader><leader>", "<cmd>Telescope live_grep<CR>", opts({ desc = "Live grep" }))
kset("n", "<leader>,", "<cmd>Telescope buffers<CR>", opts({ desc = "Buffers" }))
kset("n", "<leader>gf", "<cmd>Telescope git_files<CR>", opts({ desc = "Find Files (git-files)" }))
kset("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", opts({ desc = "Git commits" }))
kset("n", "<leader>sk", "<cmd>Telescope keymaps<CR>", opts({ desc = "Keymaps" }))
kset("n", "<leader>sR", "<cmd>Telescope registers<CR>", opts({ desc = "Registers" }))
kset("n", "<leader>sm", "<cmd>Telescope marks<CR>", opts({ desc = "Marks" }))
kset("n", "<leader>ss", function() telescope.lsp_document_symbols() end,
  opts({ desc = "Goto Symbol" }))
kset("n", "<leader>sr", "<cmd>Telescope resume<CR>", opts({ desc = "Resume previous search" }))
kset("n", "<leader>sj", "<cmd>Telescope jumplist<CR>", opts({ desc = "Jumplist" }))
kset("n", "<leader>sfp", function() vim.notify(vim.fn.expand("%:p")) end, opts({ desc = "Show full file path" }))

-- LSP
kset("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts({ desc = "Definition" }))
kset("n", "gr", "<cmd>Telescope lsp_references<CR>", opts({ desc = "References" }))
kset("n", "gI", function() telescope.lsp_implementations({ reuse_win = true }) end,
  opts({ desc = "Implementation" }))
kset("n", "gD", vim.lsp.buf.declaration, opts({ desc = "Declaration" }))
kset("n", "K", function() return vim.lsp.buf.hover() end, opts({ desc = "Hover" }))
kset("n", "gK", function() return vim.lsp.buf.signature_help() end, opts({ desc = "Signature help" }))

-- Code action
kset("n", "<leader>ca", vim.lsp.buf.code_action, opts({ desc = "Code Action" }))
kset("n", "<leader>cr", vim.lsp.buf.rename, opts({ desc = "Rename" }))
kset("n", "<leader>co",
  function()
    vim.lsp.buf.code_action({
      context = { only = { "source.organizeImports" } },
      apply = true,
    })
    vim.wait(100)
  end,
  opts({ desc = "Organize Imports" })
)
kset("n", "<leader>cd", vim.diagnostic.open_float, opts({ desc = "Show Line Diagnostics" }))
kset("n", "<leader>cD", function() telescope.diagnostics({ bufnr = 0 }) end, opts({ desc = "Show Buffer Diagnostics" }))

-- GIT
kset("n", "<leader>gg", "<cmd>LazyGit<CR>", opts({ desc = "LazyGit" }))
kset("n", "<leader>ghs", gitsigns.stage_hunk, opts({ desc = "Stage hunk" }))
kset("n", "<leader>ghr", gitsigns.reset_hunk, opts({ desc = "Reset hunk" }))
kset("n", "<leader>ghp", gitsigns.preview_hunk, opts({ desc = "Preview hunk" }))
kset("n", "<leader>ghi", gitsigns.preview_hunk_inline, opts({ desc = "Preview hunk inline" }))
kset("n", "<leader>ghb", gitsigns.blame_line, opts({ desc = "Blame line" }))
kset("n", "<leader>ght", gitsigns.toggle_current_line_blame, opts({ desc = "Toggle line blame" }))

-- YAZI
kset("n", "<leader>1", "<cmd>Yazi<CR>", opts({ desc = "Yazi - current file" }))
kset("n", "<leader>2", "<cmd>Yazi cwd<CR>", opts({ desc = "Yazi - nvim working directory" }))
kset("n", "<leader>3", "<cmd>Yazi toggle<CR>", opts({ desc = "Yazi - resume" }))


wk.add({
  { "<leader>1",  group = "Yazi" },
  { "<leader>s",  group = "Search / Show" },
  { "<leader>g",  group = "Git" },
  { "<leader>gh", group = "Hunks" },
  { "<leader>w",  group = "Window" },
  { "<leader>b",  group = "Buffers" },
  { "<leader>c",  group = "Code Action" },
})
