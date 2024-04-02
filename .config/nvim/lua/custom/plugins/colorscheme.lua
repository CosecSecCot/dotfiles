return {
    {
        "neanias/everforest-nvim",
        config = function()
            -- require("everforest").setup {
            --     -- background = "hard",
            -- }
        end,
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require("rose-pine").setup {
                styles = {
                    italic = false,
                    transparency = true,
                },
            }
        end,
    },
    {
        "mcchrish/zenbones.nvim",
        dependencies = {
            "rktjmp/lush.nvim",
        },
    },
    { "nyoom-engineering/oxocarbon.nvim" },
    { "nyoom-engineering/oxocarbon.nvim" },
    { "https://github.com/rafi/awesome-vim-colorschemes" },
    { "fcpg/vim-fahrenheit" },
    { "Lokaltog/vim-distinguished" },
    { "savq/melange-nvim" },
    { "aktersnurra/no-clown-fiesta.nvim" },
    { "adigitoleo/vim-mellow" },
    { "TheNiteCoder/mountaineer.vim" },
    { "water-sucks/darkrose.nvim" },
    { "xero/miasma.nvim" },
    { "kuuote/elly.vim" },
    { "axvr/raider.vim" },
    { "dylnmc/vulpo.vim" },
    { "Lokaltog/vim-monotone" },
    {
        "rebelot/kanagawa.nvim",
        config = function()
            require("kanagawa").setup {
                -- transparent = true,
                terminal_colors = true,
                overrides = function(_)
                    return {
                        Pmenu = { blend = vim.o.pumblend },
                    }
                end,
            }
        end,
    },
    {
        "EdenEast/nightfox.nvim",
        config = function()
            require("nightfox").setup {
                options = {
                    transparent = true,
                    terminal_colors = true,
                },
            }
        end,
    },
    {
        "ramojus/mellifluous.nvim",
        config = function()
            require("mellifluous").setup {
                dim_inactive = true,
                bg_contrast = "hard",
                color_set = "mellifluous",
                styles = { -- see :h attr-list for options. set {} for NONE, { option = true } for option
                    comments = { italic = true },
                    conditionals = { italic = true },
                    folds = {},
                    loops = {},
                    functions = {},
                    keywords = { italic = true },
                    strings = {},
                    variables = {},
                    numbers = {},
                    booleans = { italic = false, bold = true },
                    properties = {},
                    types = {},
                    operators = {},
                },
                transparent_background = {
                    enabled = true,
                    floating_windows = true,
                    telescope = true,
                    file_tree = true,
                    cursor_line = true,
                    status_line = false,
                },
                flat_background = {
                    line_numbers = false,
                    floating_windows = false,
                    file_tree = false,
                    cursor_line_number = false,
                },
                mellifluous = { -- name any of the defined color sets
                    color_overrides = {
                        dark = { -- dark variant of the color set
                            bg = nil, -- used for shades, on some color sets fg will be derived from this
                            fg = nil, -- used for shades if shades_fg is undefined
                            shades_fg = nil, -- used for shades (dimmed foregrounds)

                            main_keywords = nil,
                            other_keywords = nil,
                            types = nil,
                            operators = nil,
                            strings = nil,
                            functions = nil,
                            constants = nil,
                            comments = "#454545",

                            red = nil, -- errors, deletes, bad spellings
                            orange = nil, -- warnings, changes, unusual spellings
                            green = nil, -- staged, additions
                            blue = nil, -- information, new files
                            purple = nil, -- hints, merge

                            -- for better terminal highlights
                            yellow = nil,
                            cyan = nil,
                        },
                        light = { -- light variant of the color set
                            -- same fields as in dark variant
                        },
                    },
                },
            }
        end,
    },
    { "chiendo97/intellij.vim" },
    { "sainnhe/gruvbox-material" },
    --  'tinted-theming/base16-vim'
    { "metalelf0/base16-black-metal-scheme" },
    { "rockerBOO/boo-colorscheme-nvim" },
    {
        "folke/tokyonight.nvim",
        config = function()
            -- require("tokyonight").setup {
            -- transparent = true,
            -- styles = {
            --     sidebars = "transparent",
            --     floats = "transparent",
            -- },
            -- }
        end,
    },
    {
        "hachy/eva01.vim",
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        config = function()
            require("catppuccin").setup {
                flavour = "mocha", -- latte, frappe, macchiato, mocha
                background = { -- :h background
                    light = "latte",
                    dark = "mocha",
                },
                -- transparent_background = true, -- disables setting the background color.
                show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
                term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
                dim_inactive = {
                    enabled = false, -- dims the background color of inactive window
                    shade = "dark",
                    percentage = 0.15, -- percentage of the shade to apply to the inactive window
                },
                no_italic = false, -- Force no italic
                no_bold = false, -- Force no bold
                no_underline = false, -- Force no underline
                styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
                    comments = { "italic" }, -- Change the style of comments
                    conditionals = { "italic" },
                    loops = {},
                    functions = {},
                    keywords = {},
                    strings = {},
                    variables = {},
                    numbers = {},
                    booleans = {},
                    properties = {},
                    types = {},
                    operators = {},
                },
                color_overrides = {},
                custom_highlights = {},
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    nvimtree = true,
                    treesitter = true,
                    notify = false,
                    mini = {
                        enabled = true,
                        indentscope_color = "",
                    },
                    -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
                },
            }
        end,
    },
    { "alessandroyorba/despacio" },
    { "ntk148v/habamax.nvim", dependencies = { "rktjmp/lush.nvim" } },
    {
        "crispybaccoon/aurora",
        config = function()
            require("aurora").setup {
                transparent_background = true,
                contrast_dark = "soft",
            }
        end,
    },

    -- lazy = false,
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "habamax.nvim",
        },
    },
}
