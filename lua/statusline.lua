--[[ :h "statusline'
This is default statusline value:

```lua
vim.o.statusline = "%f %h%w%m%r%=%-14.(%l,%c%V%) %P"
```

See `:h "statusline'` for more information about statusline.
]]

---@return string
local function lsp_attached()
  local attached_clients = vim.lsp.get_clients({ bufnr = 0 })
  if #attached_clients == 0 then
    return "no lsp attached"
  end
  local names = vim.iter(attached_clients)
      :map(function(client)
        local name = client.name:gsub("language.server", "ls")
        return name
      end)
      :totable()
  return table.concat(names, ", ")
end

---@return string
local function lsp_status()
  local all_diagnostics = vim.diagnostic.get(0)

  if (not all_diagnostics or #all_diagnostics == 0) then
    return " No issues found "
  end

  local issues = {
    [vim.diagnostic.severity.ERROR] = 0,
    [vim.diagnostic.severity.WARN] = 0,
    [vim.diagnostic.severity.HINT] = 0,
    [vim.diagnostic.severity.INFO] = 0
  }
  local translation = {
    [vim.diagnostic.severity.ERROR] = "Errors",
    [vim.diagnostic.severity.WARN] = "Warnings",
    [vim.diagnostic.severity.HINT] = "Hints",
    [vim.diagnostic.severity.INFO] = "Infos"
  }

  local status = { "" }

  for _, diagnostic in ipairs(all_diagnostics) do
    issues[diagnostic.severity] = issues[diagnostic.severity] + 1
  end

  for diag, count in ipairs(issues) do
    table.insert(status, translation[diag] .. ": " .. count)
  end

  return table.concat(status, " ")
end

local function file_route()
  local file_name = vim.fn.expand("%:t")
  local work_dir = vim.fn.fnamemodify(vim.fn.getcwd(), ':t');
  local file_icon = require "nvim-web-devicons".get_icon_by_filetype(vim.bo.filetype)
  local icon = file_icon or ""
  if file_name ~= "" then
    return work_dir ..
        ' / .. / ' .. file_name .. ' ' .. icon
  end

  return work_dir
end


function _G.statusline()
  return table.concat({
    "%#Statusline#",
    lsp_status(),
    "%=",
    file_route(),
    "%h%w%m%r",
    "%=",
    lsp_attached(),
    " ",
    "%l,%c",
    "%P",
    " ",
  }, " ")
end

local bg_status = "#343B4B"

vim.o.statusline = "%{%v:lua._G.statusline()%}"

vim.api.nvim_set_hl(0, "Statusline", { fg = "#E5E9F0", bg = bg_status })

vim.api.nvim_create_autocmd("DiagnosticChanged", {
  pattern = "*",
  callback = lsp_status,
})
