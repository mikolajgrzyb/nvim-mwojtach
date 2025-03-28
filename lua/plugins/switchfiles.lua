Switchfiles = {}

local function load_buffer(buffer)
  if not buffer then
    print("Invalid buffer.")
    return
  end

  vim.api.nvim_win_set_buf(0, buffer)
end

local function get_existing_buffer(filePath)
  if not filePath or filePath == "" then
    return nil
  end

  local buffers = vim.api.nvim_list_bufs()
  for _, buf in ipairs(buffers) do
    local bufFilePath = vim.api.nvim_buf_get_name(buf)
    if bufFilePath == filePath then
      return buf
    end
  end
  return nil
end

local function open_file_in_new_buffer(filepath)
  local full_path = vim.fn.escape(filepath, "%#")
  local buffer = get_existing_buffer(full_path)
  if buffer then
    load_buffer(buffer)
    return
  end

  vim.api.nvim_command("enew")
  vim.api.nvim_command("edit " .. vim.fn.escape(filepath, "%#"))
end

local function read_files_only(dir_path)
  local files = {}
  local all_files = vim.fn.readdir(dir_path)
  for _, file in ipairs(all_files) do
    local fullpath = dir_path .. "/" .. file
    if vim.fn.isdirectory(fullpath) == 0 then
      table.insert(files, file)
    end
  end
  return files
end

local function open_files_select(dir_path)
  -- local files = vim.fn.readdir(path, {n -> n =~ '.txt$'}
  local files = read_files_only(dir_path)
  vim.ui.select(files, { prompt = "Select File:" }, function(file_name)
    if file_name then
      open_file_in_new_buffer(dir_path .. '/' .. file_name)
    end
  end)
end

function Switchfiles.switch()
  -- TODO: implement later
  local buff_name = vim.api.nvim_buf_get_name(0)
  print(buff_name)
end

function Switchfiles.select()
  local buff_name = vim.api.nvim_buf_get_name(0);
  local buff_dir = vim.fn.fnamemodify(buff_name, ':h');
  open_files_select(buff_dir)
end

return Switchfiles
