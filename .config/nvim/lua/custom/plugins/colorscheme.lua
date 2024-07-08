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
    { "rafi/awesome-vim-colorschemes" },
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
                color_set = "alduin",
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
                    enabled = false,
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
            }
        end,
    },
    { "chiendo97/intellij.vim" },
    {
        "sainnhe/gruvbox-material",
        config = function()
            vim.g.gruvbox_material_enable_italic = 1
            -- vim.g.gruvbox_material_background = "hard"
        end,
    },
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
    {
        "CosecSecCot/midnight-desert.nvim",
        dependencies = {
            "rktjmp/lush.nvim",
        },
    },
    {
        "brenoprata10/nvim-highlight-colors",
        config = function()
            require("nvim-highlight-colors").setup {
                ---Render style
                ---@usage 'background'|'foreground'|'virtual'
                render = "background",

                ---Set virtual symbol (requires render to be set to 'virtual')
                virtual_symbol = "■",

                ---Set virtual symbol suffix (defaults to '')
                virtual_symbol_prefix = "",

                ---Set virtual symbol suffix (defaults to ' ')
                virtual_symbol_suffix = " ",

                ---Set virtual symbol position()
                ---@usage 'inline'|'eol'|'eow'
                ---inline mimics VS Code style
                ---eol stands for `end of column` - Recommended to set `virtual_symbol_suffix = ''` when used.
                ---eow stands for `end of word` - Recommended to set `virtual_symbol_prefix = ' ' and virtual_symbol_suffix = ''` when used.
                virtual_symbol_position = "inline",

                ---Highlight hex colors, e.g. '#FFFFFF' '#FFFFFF'
                enable_hex = true,

                ---Highlight short hex colors e.g. '#fff'
                enable_short_hex = true,

                ---Highlight rgb colors, e.g. 'rgb(0 0 0)'
                enable_rgb = true,

                ---Highlight hsl colors, e.g. 'hsl(150deg 30% 40%)'
                enable_hsl = true,

                ---Highlight CSS variables, e.g. 'var(--testing-color)'
                enable_var_usage = true,

                ---Highlight named colors, e.g. 'green'
                enable_named_colors = true,

                ---Highlight tailwind colors, e.g. 'bg-blue-500'
                enable_tailwind = true,

                ---Set custom colors
                ---Label must be properly escaped with '%' to adhere to `string.gmatch`
                --- :help string.gmatch
                custom_colors = {
                    { label = "%-%-theme%-primary%-color", color = "#0f1219" },
                    { label = "%-%-theme%-secondary%-color", color = "#5a5d64" },
                },

                -- Exclude filetypes or buftypes from highlighting e.g. 'exclude_buftypes = {'text'}'
                exclude_filetypes = { "cpp" },
                exclude_buftypes = {},
            }
        end,
    },
    {
        "amadeus/vim-convert-color-to",
    },
    {
        "tjdevries/colorbuddy.nvim",
    },
    {
        "ntk148v/komau.vim",
    },
    {
        "CosecSecCot/cosec-twilight.nvim",
    },
    {
        "atelierbram/Base2Tone-nvim",
    },
    {
        "mswift42/vim-themes",
    },
    {
        "lunacookies/vim-colors-xcode",
    },
    -- {
    --     "LazyVim/LazyVim",
    --     opts = {
    --         colorscheme = "cosec-twilight",
    --     },
    -- },
}
