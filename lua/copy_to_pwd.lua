-- main module file
local module = require("copy_to_pwd.module")

---@class CopyToPwdConfig
---@field confirm_overwrite boolean Whether to confirm before overwriting existing files
---@field notify_on_success boolean Whether to show notification on successful copy
---@field default_keymap boolean Whether to set up default keymap
local config = {
  confirm_overwrite = true,
  notify_on_success = true,
  default_keymap = true,
}

---@class CopyToPwd
local M = {}

---@type CopyToPwdConfig
M.config = config

---@param args CopyToPwdConfig?
-- Setup function for copy-to-pwd plugin
-- Configurable options:
-- - confirm_overwrite: Ask for confirmation before overwriting existing files (default: true)
-- - notify_on_success: Show notification when file is successfully copied (default: true)
-- - default_keymap: Set up default keymap <leader>cpwd (default: true)
M.setup = function(args)
  M.config = vim.tbl_deep_extend("force", M.config, args or {})
  
  -- Set up user command
  vim.api.nvim_create_user_command(
    'CopyToPwd',
    function(opts)
      local filename = opts.fargs[1]
      M.copy_to_pwd(filename)
    end,
    {
      nargs = "?",
      desc = "Copy current buffer to present working directory",
      complete = "file"
    }
  )
  
  -- Set up default keymap if enabled
  if M.config.default_keymap then
    vim.keymap.set('n', '<leader>cpwd', ':CopyToPwd ', { desc = "Copy to pwd" })
  end
end

---Copy current buffer to pwd with optional filename
---@param filename string|nil Optional filename, defaults to current buffer name
M.copy_to_pwd = function(filename)
  local success, error_msg = module.copy_to_pwd(filename)
  
  if not success and error_msg then
    vim.notify("Error: " .. error_msg, vim.log.levels.ERROR)
  end
  
  return success
end

---Get information about current copy operation
---@return table
M.get_info = function()
  return module.get_copy_info()
end

return M
