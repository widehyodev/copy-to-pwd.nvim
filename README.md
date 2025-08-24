# copy-to-pwd.nvim

![Lua](https://img.shields.io/badge/Made%20with%20Lua-blueviolet.svg?style=for-the-badge&logo=lua)
![Neovim](https://img.shields.io/badge/NeoVim-%2357A143.svg?&style=for-the-badge&logo=neovim&logoColor=white)

A simple yet powerful Neovim plugin that allows you to quickly copy the current buffer's content to a file in your present working directory (pwd).

## ✨ Features

- **Quick File Copying**: Copy current buffer content to pwd with a single command
- **Smart Filename Detection**: Automatically uses current buffer's filename as default
- **Custom Filename Support**: Specify a different filename when copying
- **Overwrite Protection**: Confirms before overwriting existing files
- **User-Friendly**: Provides clear notifications and error messages
- **Configurable**: Customize behavior through setup options
- **Zero Dependencies**: Pure Lua implementation with no external dependencies

## 📦 Installation

### Using [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  "widehyodev/copy-to-pwd.nvim",
  config = function()
    require("copy_to_pwd").setup()
  end,
}
```

### Using [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use {
  "widehyodev/copy-to-pwd.nvim",
  config = function()
    require("copy_to_pwd").setup()
  end,
}
```

### Using [vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'widehyodev/copy-to-pwd.nvim'
```

Then add to your init.lua:
```lua
require("copy_to_pwd").setup()
```

## 🚀 Usage

### Commands

- `:CopyToPwd` - Copy current buffer to pwd using current filename
- `:CopyToPwd filename.txt` - Copy current buffer to pwd with specified filename

### Default Keymapping

- `<leader>cpwd` - Opens command line with `:CopyToPwd ` ready for filename input

### Lua API

```lua
local copy_to_pwd = require("copy_to_pwd")

-- Copy with default filename
copy_to_pwd.copy_to_pwd()

-- Copy with custom filename
copy_to_pwd.copy_to_pwd("my_file.lua")

-- Get information about current copy operation
local info = copy_to_pwd.get_info()
print(info.current_file, info.pwd, info.target_path)
```

## ⚙️ Configuration

```lua
require("copy_to_pwd").setup({
  -- Whether to confirm before overwriting existing files (default: true)
  confirm_overwrite = true,
  
  -- Whether to show notification on successful copy (default: true)
  notify_on_success = true,
  
  -- Whether to set up default keymap <leader>cpwd (default: true)
  default_keymap = true,
})
```

### Configuration Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `confirm_overwrite` | boolean | `true` | Ask for confirmation before overwriting existing files |
| `notify_on_success` | boolean | `true` | Show notification when file is successfully copied |
| `default_keymap` | boolean | `true` | Set up default keymap `<leader>cpwd` |

## 🔧 Use Cases

1. **Quick File Duplication**: Duplicate a file in your current working directory
2. **Template Creation**: Copy template files to your project directory
3. **Backup Creation**: Create quick backups of important files
4. **File Organization**: Copy files from various locations to a central directory
5. **Development Workflow**: Copy configuration files or scripts to project root

## 📋 Examples

### Example 1: Copy current file with same name
```
:CopyToPwd
```
If you're editing `/home/user/projects/myproject/src/utils.lua` and your pwd is `/home/user/projects/myproject`, this will create `/home/user/projects/myproject/utils.lua`.

### Example 2: Copy with different name
```
:CopyToPwd backup_utils.lua
```
This creates `/home/user/projects/myproject/backup_utils.lua`.

### Example 3: Using keymap
Press `<leader>cpwd`, then type the desired filename and press Enter.

## 🛠️ Requirements

- Neovim >= 0.8.0
- No external dependencies

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Inspired by common file management needs in Neovim workflows
- Built with the Neovim Lua API
