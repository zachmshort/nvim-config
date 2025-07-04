local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.prettier, -- JS, TS, HTML, CSS, etc.
		null_ls.builtins.formatting.black, -- Python
		null_ls.builtins.formatting.goimports,
		null_ls.builtins.formatting.stylua, -- Lua
		null_ls.builtins.formatting.clang_format, -- C/C++
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
			})
		end
	end,
})
