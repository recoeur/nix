return {
    "neovim/nvim-lspconfig",
    config = function()
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        local config = require("lspconfig")
        config.lua_ls.setup({ capabilities = capabilities })
        config.gopls.setup({ capabilities = capabilities })
        config.rnix.setup({ capabilities = capabilities })

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

                local opts = { buffer = ev.buf }
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                vim.keymap.set("n", "<leader>yk", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "<leader>yr", vim.lsp.buf.rename, opts)
                vim.keymap.set("n", "<leader>yf", vim.lsp.buf.code_action, opts)
            end
        })
    end,
}
