-- Internal module with core copy_to_pwd functionality
local M = {}

---Get the current buffer's filename
---@return string
local function get_buffer_file()
  return vim.fn.fnamemodify(vim.fn.expand('%'), ":t")
end

---Get the current working directory
---@return string
local function get_pwd()
  return vim.fn.getcwd()
end

---Check if a file path is valid
---@param path string
---@return boolean
local function is_valid_path(path)
  return path ~= nil and path ~= ""
end

---Copy current buffer content to the specified file in pwd
---@param filename string|nil Optional filename, defaults to current buffer name
---@return boolean success, string|nil error_msg
function M.copy_to_pwd(filename)
  local current_buffer = vim.api.nvim_get_current_buf()
  local buffer_name = vim.api.nvim_buf_get_name(current_buffer)
  
  -- Check if current buffer has content
  if buffer_name == "" then
    return false, "Current buffer has no name. Please save the buffer first or provide a filename."
  end
  
  -- Determine target filename
  local target_filename = filename
  if not filename or filename == "" then
    target_filename = get_buffer_file()
    if target_filename == "" then
      return false, "Could not determine filename. Current buffer has no name."
    end
  end
  
  -- Build target path
  local target_path = get_pwd() .. "/" .. target_filename
  
  -- Check if target file already exists
  if vim.fn.filereadable(target_path) == 1 then
    local choice = vim.fn.confirm(
      "File '" .. target_filename .. "' already exists in current directory. Overwrite?",
      "&Yes\n&No", 2
    )
    if choice ~= 1 then
      return false, "Operation cancelled by user."
    end
  end
  
  -- Copy file content
  local success, error_msg = pcall(function()
    vim.cmd("write " .. vim.fn.fnameescape(target_path))
  end)
  
  if success then
    vim.notify("File copied to: " .. target_path, vim.log.levels.INFO)
    return true, nil
  else
    return false, "Failed to copy file: " .. (error_msg or "Unknown error")
  end
end

---Get information about the current buffer and target
---@return table
function M.get_copy_info()
  local current_file = get_buffer_file()
  local pwd = get_pwd()
  
  return {
    current_file = current_file,
    pwd = pwd,
    target_path = pwd .. "/" .. current_file
  }
end

return M
