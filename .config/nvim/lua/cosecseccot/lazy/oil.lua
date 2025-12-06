return {
    "stevearc/oil.nvim",

    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,

    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
        view_options = {
            show_hidden = true,
            highlight_filename = function (entry, is_hidden, _, _)
                if entry.name == ".." then
                    return nil
                end

                if is_hidden then
                    return "Normal"
                end

                return nil
            end
        }
    },

    -- Optional dependencies
    -- dependencies = { { "nvim-mini/mini.icons", opts = {} } },
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
}
