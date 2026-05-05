return {
    {
        "mbbill/undotree",
        config = function()
            vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
        end,
    },
    {
        "stevearc/dressing.nvim",
        event = "VeryLazy",
    },
    -- {
    --     "godlygeek/tabular"
    -- },
    {
        "nvimdev/indentmini.nvim",
        event = "BufEnter",
        config = function()
            require("indentmini").setup({
                -- can be: ┆, ┊, ┋, ┇, ︙
                char = "┊",
            })

            -- Colors are applied automatically based on user-defined highlight groups.
            -- There is no default value.
            -- vim.cmd.highlight("IndentLine guifg=#252530")

            -- Current indent line highlight
            -- vim.cmd.highlight("IndentLineCurrent guifg=#606079")
        end,
    },
}
