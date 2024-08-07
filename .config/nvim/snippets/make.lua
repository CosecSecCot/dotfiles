local ls = require "luasnip" --{{{
local s = ls.s -- snippet
local i = ls.i -- insert Node
local t = ls.t -- text Node

local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local snippets, autosnippets = {}, {} --}}}

local group = vim.api.nvim_create_augroup("Lua Snippets", { clear = true })
local file_pattern = "*.lua"

local function cs(trigger, nodes, opts) --{{{
    local snippet = s(trigger, nodes)
    local target_table = snippets

    local pattern = file_pattern
    local keymaps = {}

    if opts ~= nil then
        -- check for custom pattern
        if opts.pattern then
            pattern = opts.pattern
        end

        -- if opts is a string
        if type(opts) == "string" then
            if opts == "auto" then
                target_table = autosnippets
            else
                table.insert(keymaps, { "i", opts })
            end
        end

        -- if opts is a table
        if opts ~= nil and type(opts) == "table" then
            for _, keymap in ipairs(opts) do
                if type(keymap) == "string" then
                    table.insert(keymaps, { "i", keymap })
                else
                    table.insert(keymaps, keymap)
                end
            end
        end

        -- set autocmd for each keymap
        if opts ~= "auto" then
            for _, keymap in ipairs(keymaps) do
                vim.api.nvim_create_autocmd("BufEnter", {
                    pattern = pattern,
                    group = group,
                    callback = function()
                        vim.keymap.set(keymap[1], keymap[2], function()
                            ls.snip_expand(snippet)
                        end, { noremap = true, silent = true, buffer = true })
                    end,
                })
            end
        end
    end

    table.insert(target_table, snippet) -- insert snippet into appropriate table
end --}}}

-- Start Refactoring --

local cc = s(
    "cc",
    fmt(
        [[

CXX := g++
CXXFLAGS := -std=c++20 -O2 -Wall -Wextra -pedantic -Wshadow -Wformat=2 -Wfloat-equal -Wconversion -Wshift-overflow -Wcast-qual -Wcast-align -Wno-unused-result -Wno-sign-conversion
PRECOMPILE_HEADERS := /usr/include/x86_64-linux-gnu/c++/11/bits/stdc++.h


all: run


stdc++.h.gch:
	$(CXX) $(CXXFLAGS) -xc++-header -g $(PRECOMPILE_HEADERS) -o stdc++.h.gch
.PRECIOUS: stdc++.h.gch

a.out: stdc++.h.gch a.cpp
	$(CXX) $(CXXFLAGS) -include stdc++.h a.cpp

run: a.out
	./a.out < input

clean:
	rm *.out

.PHONY: all run clean # all targets which are not files
        ]],
        {}
    )
)
table.insert(snippets, cc)

-- End Refactoring --

return snippets, autosnippets
