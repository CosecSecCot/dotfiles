return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            { "j-hui/fidget.nvim", opts = {} },
        },

        config = function()
            require("mason").setup({
                ui = {
                    border = "single",
                },
            })

            local server_configs = {
                clangd = {
                    cmd = {
                        "clangd",
                        "--clang-tidy",
                        "--cross-file-rename",
                        "--header-insertion=never",
                    },
                },
                ts_ls = {
                    init_options = {
                        preferences = {
                            includeInlayParameterNameHints = "all",
                            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                            includeInlayFunctionParameterTypeHints = true,
                            includeInlayVariableTypeHints = true,
                            includeInlayPropertyDeclarationTypeHints = true,
                            includeInlayFunctionLikeReturnTypeHints = true,
                            includeInlayEnumMemberValueHints = true,
                            importModuleSpecifierPreference = "non-relative",
                        },
                    },
                },
                emmet_language_server = {
                    filetypes = {
                        "css",
                        "eruby",
                        "html",
                        "javascript",
                        "javascriptreact",
                        "less",
                        "sass",
                        "scss",
                        "pug",
                        "typescriptreact",
                    },
                },
                lua_ls = {
                    -- cmd = {...},
                    -- filetypes = { ...},
                    -- capabilities = {},
                    settings = {
                        Lua = {
                            format = {
                                enable = true,
                                -- Put format options here
                                -- NOTE: the value should be STRING!!
                                defaultConfig = {
                                    indent_style = "space",
                                    indent_size = "2",
                                },
                            },
                            completion = {
                                callSnippet = "Replace",
                            },
                            -- hint = { enable = true },
                            -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                            -- diagnostics = { disable = { 'missing-fields' } },
                        },
                    },
                },
            }

            local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                require("cmp_nvim_lsp").default_capabilities()
            )

            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "rust_analyzer",
                    "clangd",
                },
                handlers = {
                    function(server_name)
                        local server_config = server_configs[server_name] or {}
                        server_config.capabilities = server_config.capabilities or capabilities

                        if server_name ~= "jdtls" then
                            require("lspconfig")[server_name].setup(server_config)
                        end
                    end,
                },
            })

            vim.diagnostic.config({
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = "",
                        [vim.diagnostic.severity.WARN] =  "",
                        [vim.diagnostic.severity.HINT] =  "",
                        [vim.diagnostic.severity.INFO] =  "",
                    },
                },
                -- update_in_insert = true,
                float = {
                    border = "single",
                    -- source = true,
                    -- header = "",
                    -- prefix = "",
                },
            })
        end,
    },
    {
        "onsails/lspkind.nvim",
        event = "InsertEnter",
        config = function()
            require("lspkind").init({
                -- DEPRECATED (use mode instead): enables text annotations
                --
                -- default: true
                -- with_text = true,

                -- defines how annotations are shown
                -- default: symbol
                -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
                mode = "symbol_text",

                -- default symbol map
                -- can be either 'default' (requires nerd-fonts font) or
                -- 'codicons' for codicon preset (requires vscode-codicons font)
                --
                -- default: 'default'

                -- preset = "codicons",

                -- override preset symbols
                --
                -- default: {}

                -- symbol_map = {
                --     Text = "󰉿",
                --     Method = "󰆧",
                --     Function = "󰊕",
                --     Constructor = "",
                --     Field = "󰜢",
                --     Variable = "󰀫",
                --     Class = "󰠱",
                --     Interface = "",
                --     Module = "",
                --     Property = "󰜢",
                --     Unit = "󰑭",
                --     Value = "󰎠",
                --     Enum = "",
                --     Keyword = "󰌋",
                --     Snippet = "",
                --     Color = "󰏘",
                --     File = "󰈙",
                --     Reference = "󰈇",
                --     Folder = "󰉋",
                --     EnumMember = "",
                --     Constant = "󰏿",
                --     Struct = "󰙅",
                --     Event = "",
                --     Operator = "󰆕",
                --     TypeParameter = "",
                -- },
            })
        end,
    },
    { -- Autocompletion
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            -- Snippet Engine & its associated nvim-cmp source
            {
                "L3MON4D3/LuaSnip",
                "avneesh0612/react-nextjs-snippets",
                build = (function()
                    -- Build Step is needed for regex support in snippets.
                    -- This step is not supported in many windows environments.
                    -- Remove the below condition to re-enable on windows.
                    if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
                        return
                    end
                    return "make install_jsregexp"
                end)(),
            },
            "saadparwaiz1/cmp_luasnip",

            -- Adds other completion capabilities.
            --  nvim-cmp does not ship with all sources by default. They are split
            --  into multiple repos for maintenance purposes.
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            luasnip.config.setup({})
            require("luasnip.loaders.from_lua").lazy_load({ paths = { "~/.config/nvim/snippets" } }) -- load snippets
            require("luasnip.loaders.from_vscode").lazy_load()
            -- require("vim-react-snippets").lazy_load()
            --

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                completion = { completeopt = "menu,menuone,noinsert" },
                window = {
                    -- diagnostic = cmp.config.window.bordered(),
                    documentation = {
                        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,Search:None",
                        -- border = "single",
                    },

                    -- completion = cmp.config.window.bordered(),
                },

                -- For an understanding of why these mappings were
                -- chosen, you will need to read `:help ins-completion`
                --
                -- No, but seriously. Please read `:help ins-completion`, it is really good!
                mapping = cmp.mapping.preset.insert({
                    -- Select the [n]ext item
                    ["<C-n>"] = cmp.mapping.select_next_item(),
                    -- Select the [p]revious item
                    ["<C-p>"] = cmp.mapping.select_prev_item(),

                    -- Scroll the documentation window [b]ack / [f]orward
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),

                    -- Accept ([y]es) the completion.
                    --  This will auto-import if your LSP supports it.
                    --  This will expand snippets if the LSP sent a snippet.
                    ["<Tab>"] = cmp.mapping.confirm({ select = true }),

                    -- Manually trigger a completion from nvim-cmp.
                    --  Generally you don't need this, because nvim-cmp will display
                    --  completions whenever it has completion options available.
                    ["<C-Space>"] = cmp.mapping.complete({}),

                    -- Think of <c-l> as moving to the right of your snippet expansion.
                    --  So if you have a snippet that's like:
                    --  function $name($args)
                    --    $body
                    --  end
                    --
                    -- <c-l> will move you to the right of each of the expansion locations.
                    -- <c-h> is similar, except moving you backwards.
                    ["<C-l>"] = cmp.mapping(function()
                        if luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        end
                    end, { "i", "s" }),
                    ["<C-h>"] = cmp.mapping(function()
                        if luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        end
                    end, { "i", "s" }),
                    ["<C-j>"] = cmp.mapping(function()
                        if luasnip.choice_active() then
                            luasnip.change_choice(1)
                        end
                    end, { "i", "s" }),

                    -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
                    --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
                }),
                sources = {
                    { name = "nvim_lsp" },
                    { name = "path" },
                    { name = "luasnip", max_item_count = 5 },
                    { name = "buffer", keyword_length = 5, max_item_count = 5 },
                },
                experimental = {
                    ghost_text = false,
                },
                formatting = {
                    expandable_indicator = false,
                    fields = {
                        "icon",
                        "abbr",
                        "kind",
                        -- "menu"
                    },
                    format = require("lspkind").cmp_format({
                        mode = "text",
                        -- maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                        -- can also be a function to dynamically calculate max width such as
                        maxwidth = function()
                            return math.floor(0.45 * vim.o.columns)
                        end,
                        ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
                        show_labelDetails = false, -- show labelDetails in menu. Disabled by default
                        -- menu = {
                        -- 	nvim_lsp = "[LSP]",
                        -- 	path = "[PATH]",
                        -- 	luasnip = "[SNIP]",
                        -- 	buffer = "[buff]",
                        -- },
                    }),
                },
            })
        end,
    },
    {
        "stevearc/conform.nvim",
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    lua = { "stylua" },
                    -- Conform can also run multiple formatters sequentially
                    -- python = { "isort", "black" },
                    --
                    -- You can use a sub-list to tell conform to run *until* a formatter
                    -- is found.
                    javascript = { "prettier" },
                    typescript = { "prettier" },
                    javascriptreact = { "prettier" },
                    typescriptreact = { "prettier" },
                    python = { "autopep8" },
                    cpp = { "clang-format" },
                    c = { "clang-format" },
                },
            })
        end,
    },
    {
        "mfussenegger/nvim-lint",
        event = {
            "BufReadPre",
            "BufNewFile",
        },
        config = function()
            local lint = require("lint")

            lint.linters_by_ft = {
                javascript = { "eslint_d" },
                typescript = { "eslint_d" },
                javascriptreact = { "eslint_d" },
                typescriptreact = { "eslint_d" },
                -- python = { "pylint" },
                -- cpp = { "cpplint" },
            }

            local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

            vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
                group = lint_augroup,
                callback = function()
                    lint.try_lint()
                end,
            })

            -- vim.keymap.set("n", "<leader>l", function()
            --     lint.try_lint()
            -- end, { desc = "Trigger linting for current file" })
        end,
    },
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
}
