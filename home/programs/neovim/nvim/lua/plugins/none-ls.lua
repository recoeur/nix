return {
	{
		"nvimtools/none-ls.nvim",
		config = function()
			local n = require("null-ls")
			n.setup({
				sources = {
					n.builtins.formatting.stylua,
					n.builtins.diagnostics.golangci_lint,
				},
			})
			vim.keymap.set("n", "<leader>df", vim.lsp.buf.format, {})
		end,
	},
}
