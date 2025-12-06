-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
--

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

-- Tab width for different filetypes
vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "json",
        "jsonc",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
    },
    callback = function()
        vim.bo.tabstop = 2
        vim.bo.shiftwidth = 2
        vim.bo.softtabstop = 2
    end,
})

vim.api.nvim_create_autocmd('LspAttach', {
    -- group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "g.", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "grn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format() end, opts)
    end
})
