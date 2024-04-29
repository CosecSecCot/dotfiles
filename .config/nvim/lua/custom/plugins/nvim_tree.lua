return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local nvimtree = require "nvim-tree"
        -- local nonicons_extention = require "nvim-nonicons.extentions.nvim-tree"
        nvimtree.setup {
            renderer = {
                icons = {
                    --         -- glyphs = nonicons_extention.glyphs,
                    -- indent_markers = {
                    --     inline_arrows = false,
                    -- },
                    symlink_arrow = " 󰁜 ",
                    show = {
                        diagnostics = false,
                    },
                    glyphs = {
                        git = {
                            unstaged = "M",
                            staged = "S",
                            unmerged = "",
                            renamed = "R",
                            untracked = "U",
                            deleted = "",
                            ignored = "◌",
                        },
                    },
                },
            },
            disable_netrw = true,
            hijack_netrw = true,
            actions = {
                open_file = {
                    quit_on_open = true,
                },
            },
            view = {
                width = 30,
            },
            filters = {
                git_ignored = false,
                custom = {
                    -- ".DS_Store",
                },
            },
            update_focused_file = {
                enable = true,
                update_root = true,
                ignore_list = { "help" },
            },
        }

        -- Keymaps
        vim.keymap.set("n", "<leader>pv", "<cmd>NvimTreeToggle<CR>")
    end,
}
