return {
    {
        "vague-theme/vague.nvim",
        config = function()
            require("vague").setup({
                transparent = false,
                style = {
                    strings = "none",
                },
                on_highlights = function(hl, color)
                    hl.IndentLine = { fg = color.line }
                    hl.IndentLineCurrent = { fg = color.comment }
                end,
            })
        end,
    },
    {
        "rebelot/kanagawa.nvim",
        opts = {
            -- transparent = true,
            terminal_colors = true,
            background = {
                -- light = "lotus",
                dark = "wave", -- "wave, dragon"
            },
            colors = {
                palette = {
                    -- Background colors
                    sumiInk0 = "#161616", -- modified
                    sumiInk1 = "#181818", -- modified
                    sumiInk2 = "#1a1a1a", -- modified
                    sumiInk3 = "#1F1F1F", -- modified
                    sumiInk4 = "#2A2A2A", -- modified
                    sumiInk5 = "#363636", -- modified
                    sumiInk6 = "#545454", -- modified

                    -- Popup and Floats
                    waveBlue1 = "#322C47", -- modified
                    waveBlue2 = "#4c4464", -- modified

                    -- Diff and Git
                    winterGreen = "#2B3328",
                    winterYellow = "#49443C",
                    winterRed = "#43242B",
                    winterBlue = "#252535",
                    autumnGreen = "#76A56A", -- modified
                    autumnRed = "#C34043",
                    autumnYellow = "#DCA561",

                    -- Diag
                    samuraiRed = "#E82424",
                    roninYellow = "#FF9E3B",
                    waveAqua1 = "#7E9CD8", -- modified
                    dragonBlue = "#7FB4CA", -- modified

                    -- Foreground and Comments
                    oldWhite = "#C8C093",
                    fujiWhite = "#F9E7C0", -- modified
                    fujiGray = "#727169",
                    oniViolet = "#BFA3E6", -- modified
                    oniViolet2 = "#BCACDB", -- modified
                    crystalBlue = "#8CABFF", -- modified
                    springViolet1 = "#938AA9",
                    springViolet2 = "#9CABCA",
                    springBlue = "#7FC8EF", -- modified
                    waveAqua2 = "#77AEDA", -- modified

                    springGreen = "#98BB6C",
                    boatYellow1 = "#938056",
                    boatYellow2 = "#C0A36E",
                    carpYellow = "#FFEE99", -- modified

                    -- sakuraPink = "#D27E99",
                    sakuraPink = "#D27E7E",
                    waveRed = "#E46876",
                    peachRed = "#FF5D62",
                    surimiOrange = "#FFAA44", -- modified
                    katanaGray = "#717C7C",
                },
            },
            overrides = function(c)
                return {
                    Pmenu = { blend = vim.o.pumblend },
                    IndentLine = { fg = c.palette.sumiInk5 },
                    IndentLineCurrent = { fg = c.palette.sumiInk6 },
                }
            end,
        },
        config = function(_, opts)
            require("kanagawa").setup(opts)
            -- vim.cmd "colorscheme kanagawa-dragon"

            -- Custom diff colors
            vim.cmd([[
              autocmd VimEnter kanagawa hi DiffAdd guifg=#00FF00 guibg=#005500
              autocmd VimEnter kanagawa hi DiffDelete guifg=#FF0000 guibg=#550000
              autocmd VimEnter kanagawa hi DiffChange guifg=#CCCCCC guibg=#555555
              autocmd VimEnter kanagawa hi DiffText guifg=#00FF00 guibg=#005500
            ]])

            -- Custom border colors
            vim.cmd([[
              autocmd ColorScheme kanagawa hi NormalFloat guifg=#F9E7C0 guibg=#101010
              autocmd ColorScheme kanagawa hi FloatBorder guifg=#F9E7C0 guibg=#101010
            ]])

            -- vim.cmd("colorscheme kanagawa")
        end,
    },
    {
        "brenoprata10/nvim-highlight-colors",
        config = function()
            require("nvim-highlight-colors").setup({
                ---Render style
                ---@usage 'background'|'foreground'|'virtual'
                render = "virtual",

                ---Set virtual symbol (requires render to be set to 'virtual')
                virtual_symbol = "",

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
                exclude_buftypes = { "cpp" },
            })
        end,
    },
    {
        "amadeus/vim-convert-color-to",
    },
}
