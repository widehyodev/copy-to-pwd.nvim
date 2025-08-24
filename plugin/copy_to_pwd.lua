-- Plugin entry point for copy-to-pwd.nvim
-- This file is automatically loaded by Neovim

-- Prevent loading the plugin multiple times
if vim.g.loaded_copy_to_pwd then
  return
end
vim.g.loaded_copy_to_pwd = 1

-- Set up the plugin without requiring manual setup call for basic functionality
-- Users can still call setup() for custom configuration
local copy_to_pwd = require("copy_to_pwd")

-- Set up with default configuration
copy_to_pwd.setup()
