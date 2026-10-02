local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Apply completion capabilities to every server. Server defaults are supplied
-- by nvim-lspconfig's lsp/ directory and extended below with local settings.
vim.lsp.config('*', {
  capabilities = lsp_capabilities,
})

vim.lsp.config('lua_ls', {
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if path ~= vim.fn.stdpath('config')
          and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then
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
  settings = { Lua = {} },
})

vim.lsp.config('vtsls', {
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
})

vim.lsp.config('angularls', {
  filetypes = { "typescript", "html", "angular", "htmlangular" },
  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = false
  end,
})

vim.lsp.enable({
  'lua_ls',
  'vtsls',
  'intelephense',
  'emmet_language_server',
  'cssls',
  'angularls',
})
