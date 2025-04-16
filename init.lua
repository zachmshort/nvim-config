local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()
require("core.options")
require("core.keymaps")
require("core.remaps")

-- Plugins setup
require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")
	use("AndrewRadev/splitjoin.vim")
	-- Comment plugin
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("plugins.comment")
		end,
	})

	use({
		"L3MON4D3/LuaSnip",
		config = function()
			require("plugins.snippets")
		end,
	})

	-- Color scheme
	use({
		"rose-pine/neovim",
		as = "rose-pine",
		config = function()
			require("plugins.colors")
		end,
	})

	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("plugins.telescope")
		end,
	})

	-- Terminal
	use({
		"akinsho/toggleterm.nvim",
		tag = "*",
		config = function()
			require("plugins.terminal")
		end,
	})

	-- Tree-sitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
		config = function()
			require("plugins.tree-sitter")
		end,
	})
	use("nvim-treesitter/nvim-treesitter-textobjects")
	use("nvim-treesitter/nvim-treesitter-context")

	-- LSP Setup with dependencies to ensure proper loading order
	use({
		"neovim/nvim-lspconfig",
		requires = {
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
		},
		config = function()
			-- We'll load the LSP config from a separate file
			require("plugins.lsp").setup()
		end,
	})

	use({
		"nvimtools/none-ls.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("plugins.formatting")
		end,
	})

	use({ "tpope/vim-fugitive" })

	use({
		"kylechui/nvim-surround",
		config = function()
			require("nvim-surround").setup({})
		end,
	})

	use({
		"windwp/nvim-autopairs",
		config = function()
			require("plugins.autopairs").setup()
		end,
	})

	use({
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	})

	-- Autocompletion plugins
	use({
		"hrsh7th/nvim-cmp",    -- Completion engine
		requires = {
			{ "hrsh7th/cmp-nvim-lsp" }, -- LSP source for nvim-cmp
			{ "hrsh7th/cmp-buffer" }, -- Buffer source for completions
			{ "hrsh7th/cmp-path" }, -- Path source for completions
			{ "hrsh7th/cmp-cmdline" }, -- Command line source for completions
			{ "saadparwaiz1/cmp_luasnip" }, -- Snippets source for nvim-cmp
			{ "L3MON4D3/LuaSnip" }, -- Snippets engine
			{ "rafamadriz/friendly-snippets" }, -- Collection of snippets
		},
		config = function()
			require("plugins.completion").setup()
		end,
	})

	-- Automatically set up your configuration after cloning packer.nvim
	if packer_bootstrap then
		require("packer").sync()
	end
end)
