-------------------------
-- LSP CONFIGURATION   --
-- (Language Servers)  --
-------------------------

local M = {}

-- Define the setup function that will be called from init.lua
M.setup = function()
	-- Set up nvim-cmp capabilities
	local capabilities = require("cmp_nvim_lsp").default_capabilities()
	-- Initialize Mason first
	require("mason").setup({
		ui = {
			icons = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗",
			},
		},
	})
	-- Then set up Mason-LSPConfig
	require("mason-lspconfig").setup({
		ensure_installed = { "lua_ls" }, -- We'll handle TS server separately
	})
	-- Diagnostic keymaps
	vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
	vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
	-- Configure diagnostic display
	vim.diagnostic.config({
		virtual_text = true,
		signs = true,
		underline = true,
		update_in_insert = false,
		severity_sort = true,
		float = {
			border = "rounded",
		},
	})
	-- LSP handlers configuration
	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})
	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})

	-- Use an on_attach function to only map the following keys
	-- after the language server attaches to the current buffer
	local on_attach = function(client, bufnr)
		-- Enable completion triggered by <c-x><c-o>
		vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

		-- Key mappings
		local bufopts = { noremap = true, silent = true, buffer = bufnr }

		-- Jump definitions
		vim.keymap.set(
			"n",
			"<leader>jg",
			vim.lsp.buf.declaration,
			{ desc = "Jump to global declaration", buffer = bufnr }
		)
		vim.keymap.set("n", "<leader>jf", vim.lsp.buf.definition,
			{ desc = "Jump to local definition", buffer = bufnr })
		vim.keymap.set(
			"n",
			"<leader>jp",
			"<cmd>Lspsaga peek_definition<CR>",
			{ desc = "Peek definition", buffer = bufnr }
		)
		vim.keymap.set("n", "<leader>jb", "<C-o>", { desc = "Jump back in jumplist", buffer = bufnr })
		vim.keymap.set("n", "<leader>jn", "<C-i>", { desc = "Jump forward in jumplist", buffer = bufnr })

		vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
		vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
		vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
		vim.keymap.set("n", "<leader>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, bufopts)
		vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
		vim.keymap.set("n", "<leader>f", function()
			vim.lsp.buf.format({ async = true })
		end, bufopts)

		vim.keymap.set("n", "<Esc>", function()
			for _, win in ipairs(vim.api.nvim_list_wins()) do
				local config = vim.api.nvim_win_get_config(win)
				if config.relative ~= "" then
					vim.api.nvim_win_close(win, false)
					return
				end
			end
			vim.cmd("nohlsearch")
		end, bufopts)
	end

	-- Get LSPConfig
	local lspconfig = require("lspconfig")

	-- Setup servers with capabilities for autocompletion
	lspconfig.lua_ls.setup({
		on_attach = on_attach,
		capabilities = capabilities, -- Add nvim-cmp capabilities
		settings = {
			Lua = {
				diagnostics = {
					-- Recognize the vim global
					globals = { "vim" },
				},
				workspace = {
					-- Make the server aware of Neovim runtime files
					library = vim.api.nvim_get_runtime_file("", true),
					checkThirdParty = false,
				},
				telemetry = {
					enable = false,
				},
			},
		},
	})

	-- Try TypeScript server - first try ts_ls (new name)
	local ts_ok = pcall(function()
		lspconfig.ts_ls.setup({
			on_attach = on_attach,
			capabilities = capabilities, -- Add nvim-cmp capabilities
		})
	end)

	-- If that fails, try tsserver (old name)
	if not ts_ok then
		pcall(function()
			lspconfig.tsserver.setup({
				on_attach = on_attach,
				capabilities = capabilities, -- Add nvim-cmp capabilities
			})
		end)
	end

	-- Setup Tailwind CSS server
	pcall(function()
		lspconfig.tailwindcss.setup({
			on_attach = on_attach,
			capabilities = capabilities, -- Add nvim-cmp capabilities
		})
	end)
end

return M
