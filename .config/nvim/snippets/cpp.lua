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
/*
 * Author: CosecSecCot
 * Created: {d}
 * */
#include <bits/stdc++.h>
using namespace std;
using ll = long long;
using ld = long double;
using ull = unsigned long long;
#define pb push_back
#define fi first
#define se second
#define all(x) (x).begin(), (x).end()
#define yn(x) cout << (x ? "YES" : "NO")
#define yes cout << "YES"
#define no cout << "NO"
#define ynnl(x) cout << (x ? "YES\n" : "NO\n")
#define yesnl cout << "YES\n"
#define nonl cout << "NO\n"
#define fastio                                                                                                         \
    ios::sync_with_stdio(false);                                                                                       \
    cin.tie(nullptr);                                                                                                  \
    cout.tie(nullptr)

void solve() {{
    {}
}}

signed main() {{
    fastio;
#ifndef ONLINE_JUDGE
    freopen("input", "r", stdin);
#endif
    int test = 1;
    cin >> test;
    while (test--) {{
        solve();
        cout << '\n';
    }}

    return 0;
}}
    ]],
        {
            d = t(os.date "%A, %d %B %Y, %I:%M:%S %p"),
            i(1, ""),
        }
    )
)
table.insert(snippets, cc)

local boilerplate = s(
    "boilerplate",
    fmt(
        [[
    #include <iostream>
    using namespace std;
    #define ll long long

    {}

    int main()
    {{
        ios_base::sync_with_stdio(false);
        cin.tie(nullptr);
        cout.tie(nullptr);
    #ifndef ONLINE_JUDGE 
        freopen("input", "r", stdin); 
    #endif 

        return 0;
    }}
    ]],
        {
            i(0, ""),
        }
    )
)
table.insert(snippets, boilerplate)

local leetcode = s(
    "leetcode",
    fmt(
        [[
    #include <iostream>
    using namespace std;

    class Solution {{
    public:
        {}
    }};

    int main()
    {{
        ios_base::sync_with_stdio(false);
        cin.tie(nullptr);
        cout.tie(nullptr);

        Solution solution;

        return 0;
    }}
    ]],
        {
            i(0, ""),
        }
    )
)
table.insert(snippets, leetcode)

local aoc = s(
    "aoc",
    fmt(
        [[
#include <fstream>
#include <iostream>
using namespace std;

int main() {{
    ifstream input_file("../input");
    string line;
    vector<string> lines;
    while (getline(input_file, line)) {{
        lines.push_back(line);
    }}

    {}

    return 0;
}}

    ]],
        {
            i(0, ""),
        }
    )
)
table.insert(snippets, aoc)
-- End Refactoring --

return snippets, autosnippets
