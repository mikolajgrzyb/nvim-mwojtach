local M = {}

function M.print_diagnostics()
  local function by_line_num(a, b)
    return a.lnum < b.lnum
  end

  local diagnostics = vim.diagnostic.get(0)
  if (not diagnostics or #diagnostics == 0) then
    vim.notify("No issues found", vim.log.levels.INFO)
    return
  end

  table.sort(diagnostics, by_line_num)
  local messages = { "" }
  local sev_text = {
    [vim.diagnostic.severity.ERROR] = "Error",
    [vim.diagnostic.severity.WARN] = "Warning"
  }
  for _, d in ipairs(diagnostics) do
    local sev = sev_text[d.severity] or "Info"
    table.insert(messages, sev .. ": " .. d.message .. " [" .. d.lnum .. ":" .. d.col .. "]")
  end
  vim.notify(table.concat(messages, "\n"), vim.log.levels.ERROR)
end

vim.diagnostic.config({
  virtual_text = true,        -- optional: disable inline virtual_text
  virtual_lines = {
    only_current_line = true, -- show virtual lines only on the current line (optional)
  },
})

return M
