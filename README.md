# Neovim Configuration

This is my custom Neovim configuration, designed to be fast, efficient, and
highly customizable for development. It includes essential plugins for code
completion, linting, syntax highlighting, version control, and more.

## Prerequisites

- [Neovim](https://neovim.io/) version 0.5.0 or later.
- [Git](https://git-scm.com/) for managing plugins.

## Installation

### 1. Clone the repository

Clone this repository into your `~/.config/nvim` directory or wherever you
manage your Neovim configurations.

```bash
git clone https://github.com/yourusername/nvim-config.git ~/.config/nvim
```

### 2. Install Packer

The configuration uses Packer as the plugin manager. If Packer is not
installed, it will be installed automatically the first time you run Neovim
with this config.

### 3. Install the plugins

Once you've cloned the repository, open Neovim and run the following command
to install all the plugins:

```bash
:PackerSync
```

This will install all the necessary plugins as specified in the init.lua
configuration.

## Features

Plugin List
Here are the major plugins included in this configuration:

Packer.nvim - Plugin manager for Neovim.

splitjoin.vim - Quickly split or join lines based on context.

Comment.nvim - Easy commenting with gcc, gc, etc.

LuaSnip - Snippet engine.

Undotree - Visualize undo history.

Rose-pine - Beautiful color scheme.

Telescope.nvim - Fuzzy finder for files, buffers, etc.

Toggleterm.nvim - Easy terminal integration inside Neovim.

Tree-sitter - Advanced syntax highlighting and text objects.

LSP (Language Server Protocol) - Provides features like code
completion, diagnostics, etc.

None-ls.nvim - Integrates external formatters and linters.

Vim-fugitive - Git integration within Neovim.

Nvim-surround - Surround text objects with pairs like brackets, quotes,
etc.

Nvim-autopairs - Automatically closes pairs of brackets, quotes, etc.

Nvim-cmp - Autocompletion plugin with support for LSP, snippets, and
more.

## Key Features

LSP support for autocompletion, diagnostics, and more.

Snippets support with LuaSnip.

Git integration via Fugitive.

Code formatting and linting via None-ls.

Fuzzy searching with Telescope.

Terminal inside Neovim with Toggleterm.

Surrounding text manipulation with Nvim-surround and Nvim-autopairs.

Configuration
Your personal configuration is located in ~/.config/nvim/lua/plugins/. Here,
you can add or adjust the configuration of each plugin.

Example Plugin Customization
To modify the Comment.nvim plugin, you can adjust the settings in the
lua/plugins/comment.lua file. Similarly, for other plugins like Telescope
or LSP, you can find their respective configurations in the lua/plugins/
folder.

Keybindings
Here are some of the keybindings I use:

gcc - Comment handling, allows for directional inputs such as gc2j to comment out current line and 2 lines down.

<leader>ff - Open Telescope file finder.
<leader>ff - Open Telescope file finder.

<leader>jf - Jump to defintion.
<leader>jb - Jump back after jumping to a defition.

<leader>fg - Search for a Git file.

<leader>bb - Open Telescope buffer list.

<leader>tf - Open floating terminal, there are others like side and bottom terminal.

Troubleshooting
If Packer doesn't install properly, try running :PackerSync again.

If you encounter any issues with plugins, check if they are properly
configured in lua/plugins/.

Ensure your Neovim is up-to-date (>= 0.5.0).

### Contributions

Feel free to fork and modify this configuration for your own use. If you'd
like to contribute improvements or fixes, open an issue or submit a pull
request!

### License

This configuration is open-source and free to anyone
