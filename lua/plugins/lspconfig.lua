local lspconfig = require 'lspconfig'
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
local util = require 'lspconfig.util'

local client_capabilities = vim.lsp.protocol.make_client_capabilities()
client_capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.lua_ls.setup {
  capabilities = lsp_capabilities,
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if path ~= vim.fn.stdpath('config') and (vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc')) then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT'
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME
          -- Depending on the usage, you might want to add additional paths here.
          -- "${3rd}/luv/library"
          -- "${3rd}/busted/library",
        }
        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
        -- library = vim.api.nvim_get_runtime_file("", true)
      }
    })
  end,
  settings = {
    Lua = {}
  }
}

lspconfig.vtsls.setup {
  settings = {
    typescript = {
      preferences = {
        importModuleSpecifier = "project-relative",
        importModuleSpecifierPreference = "relative",
        importModuleSpecifierEnding = "minimal",
      },
      inlayHints = {
        parameterNames = { enabled = "all" },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
    },
  },
}

lspconfig.intelephense.setup {}

lspconfig.emmet_language_server.setup {}

lspconfig.cssls.setup {
  capabilities = client_capabilities,
}

-- lspconfig.html.setup {}

-- lspconfig.html.setup {
--   capabilities = client_capabilities,
--   cmd = { 'vscode-html-language-server', '--stdio' },
--   filetypes = {
--     "html",
--     "templ",
--     "blade",
--     "hbs",
--   },
--   root_dir = util.root_pattern('package.json', '.git'),
--   single_file_support = true,
--   settings = {},
--   init_options = {
--     provideFormatter = true,
--     embeddedLanguages = { css = true, javascript = true },
--     configurationSection = { 'html', 'css', 'javascript' },
--   },
-- }

lspconfig.angularls.setup {
  capabilities = lsp_capabilities,
  filetypes = { "typescript", "html", "angular" },
  root_dir = function(fname)
    return require("lspconfig.util").root_pattern(
      "angular.json",
      "workspace.json",
      "nx.json",
      "package.json",
      "tsconfig.base.json"
    )(fname)
  end,
  on_new_config = function(new_config, new_root_dir)
    new_config.cmd = {
      "ngserver",
      "--stdio",
      "--tsProbeLocations",
      new_root_dir,
      "--ngProbeLocations",
      new_root_dir,
    }
  end,
}

local function filterDuplicates(array)
  local uniqueArray = {}
  for _, tableA in ipairs(array) do
    local isDuplicate = false
    for _, tableB in ipairs(uniqueArray) do
      if vim.deep_equal(tableA, tableB) then
        isDuplicate = true
        break
      end
    end
    if not isDuplicate then
      table.insert(uniqueArray, tableA)
    end
  end
  return uniqueArray
end

local function on_list(options)
  vim.notify('ON LIST')
  options.items = filterDuplicates(options.items)
  vim.fn.setqflist({}, ' ', options)
  vim.cmd('botright copen')
end

vim.lsp.buf.references(nil, { on_list = on_list })
