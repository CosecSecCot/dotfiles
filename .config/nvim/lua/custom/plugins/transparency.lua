return {
    "xiyaowong/transparent.nvim",
    lazy = false,
    config = function()
        require("transparent").setup {
            extra_groups = {
                "DiagnosticSignError",
                "DiagnosticSignHint",
                "DiagnosticSignInfo",
                "DiagnosticSignOk",
                "DiagnosticSignWarn",

                "TelescopeBorder",

                "NormalFloat",
                "FloatBorder",
            },
        }

        vim.keymap.set("n", "<leader>tr", [[<cmd>TransparentToggle<CR>]])
    end,
}
