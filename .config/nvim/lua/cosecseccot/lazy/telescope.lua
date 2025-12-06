return {
    "nvim-telescope/telescope.nvim",
    priority = 1000,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-file-browser.nvim",
    },
    config = function()
        require("telescope").setup({})

        local builtin = require("telescope.builtin")

        vim.keymap.set("n", "<leader>pf", function()
            builtin.find_files({ hidden = true })
        end, { desc = "[P]roject [F]iles" })

        vim.keymap.set("n", "<leader>gf", builtin.git_files, { desc = "[G]it Project [F]iles" })

        vim.keymap.set("n", "<leader>ps", builtin.live_grep, { desc = "[P]roject [S]earch by Grep" })

        vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "Find existing buffers" })

        vim.keymap.set("n", "<leader>s/", function()
            builtin.live_grep({
                grep_open_files = true,
                prompt_title = "Live Grep in Open Files",
            })
        end, { desc = "[S]earch [/] in Open Files" })

        -- https://github.com/nvim-telescope/telescope.nvim/issues/2201
        vim.keymap.set("n", "<leader>pS", function()
            local action_state = require("telescope.actions.state")
            local fb = require("telescope").extensions.file_browser
            local live_grep = require("telescope.builtin").live_grep
            local current_line = action_state.get_current_line()

            fb.file_browser({
                files = false,
                depth = false,
                attach_mappings = function()
                    require("telescope.actions").select_default:replace(function()
                    local entry_path = action_state.get_selected_entry().Path
                    local dir = entry_path:is_dir() and entry_path or entry_path:parent()
                    local relative = dir:make_relative(vim.fn.getcwd())
                    local absolute = dir:absolute()

                        live_grep({
                            results_title = relative .. "/",
                            cwd = absolute,
                            default_text = current_line,
                        })
                    end)

                    return true
                end,
            })
        end, { desc = "[p]roject-wide [S]earch (in current directory)" })
    end,
}
