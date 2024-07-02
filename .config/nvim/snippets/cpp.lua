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
#define len(x) ((ll)(x).size())
#define sum(x) accumulate(all(x), 0)
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
#define __printvec(vec)                                                                                                \
    {{                                                                                                                 \
        cout << "[";                                                                                                   \
        for (size_t i = 0; i < (vec).size(); ++i) {{                                                                     \
            cout << (vec)[i];                                                                                            \
            if (i != (vec).size() - 1)                                                                                   \
                cout << ", ";                                                                                          \
        }}                                                                                                             \
        cout << "]" << '\n';                                                                                           \
    }}
#define __print2dvec(vec)                                                                                              \
    {{                                                                                                                 \
        cout << "[" << '\n';                                                                                           \
        for (auto &v : (vec)) {{                                                                                         \
            cout << '\t';                                                                                              \
            __printvec(v);                                                                                             \
        }}                                                                                                             \
        cout << "]" << '\n';                                                                                           \
    }}
#define __printpair(pair) cout << "<" << pair.fi << ", " << pair.se << ">" << '\n'

const vector<pair<int, int>> dir4 = {{{{0, -1}}, {{1, 0}}, {{0, 1}}, {{-1, 0}}}};
const vector<pair<int, int>> dir8 = {{{{0, -1}}, {{1, -1}}, {{1, 0}}, {{1, 1}}, {{0, 1}}, {{-1, 1}}, {{-1, 0}}, {{-1, -1}}}};

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
            -- d = t(os.date "%A, %d %B %Y, %I:%M:%S %p"),
            -- time = t(vim.fn.strftime("%c", vim.fn.getftime "")),
            d = f(function(_, snip)
                local res, env = {}, snip.env
                table.insert(
                    res,
                    " "
                        .. env.CURRENT_DAY_NAME
                        .. ", "
                        .. env.CURRENT_DATE
                        .. " "
                        .. env.CURRENT_MONTH_NAME_SHORT
                        .. " "
                        .. env.CURRENT_YEAR
                        .. " - "
                        .. env.CURRENT_HOUR
                        .. ":"
                        .. env.CURRENT_MINUTE
                        .. ":"
                        .. env.CURRENT_SECOND
                )
                return res
            end),
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

    int main() {{
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

-- ## ALGORITHMS ##
local graphinp = s(
    "graphinp",
    fmt(
        [[
    int n, m;
    cin >> n >> m;
    vector<vector<int>> graph;
    for (int i = 0; i < m; i++) {{
        int u, v;
        cin >> u >> v;
        graph[u].pb(v);
        {}
    }}
    {}
        ]],
        {
            i(1, "graph[v].pb(u);"),
            i(0, ""),
        }
    )
)
table.insert(snippets, graphinp)

local dfsadjlist = s(
    "dfsadj",
    fmt(
        [[
void dfs(int curr, vector<vector<int>> &adj_list, vector<bool> &visited{}) {{
    visited[curr] = true;
    {}
    for (auto next_node : adj_list[curr]) {{
        if (!visited[next_node]) {{
            dfs(next_node, adj_list, visited);
        }}
    }}
}}
    ]],
        {
            i(1, ", /* more parameters */"),
            i(0, "/* any condition */"),
        }
    )
)
table.insert(snippets, dfsadjlist)

local dfsgrid = s(
    "dfsgrid",
    fmt(
        [[
void dfs(int y, int x, vector<vector<{}>> &grid, vector<vector<bool>> &visited{}) {{
    visited[y][x] = true;
    for (auto &[dirx, diry] : {}) {{
        int newY = y + diry;
        int newX = x + dirx;
        if (newY < 0 || newY >= grid.size() || newX < 0 || newX >= grid[0].size())
            continue;

        {}
    }}
}}
    ]],
        {
            i(1, "/* type */"),
            i(2, ", /* more parameters */"),
            c(3, {
                t "dir4",
                t "dir8",
            }),
            i(0, ""),
        }
    )
)
table.insert(snippets, dfsgrid)

local bipertite2 = s(
    "bipertite2",
    fmt(
        [[
bool bipertite2(int curr, vector<vector<int>> &adj_list, vector<int> &color, int currcolor) {{
    color[curr] = currcolor;

    for (auto next_node : adj_list[curr]) {{
        if (color[next_node] == -1) {{
            if (!bipertite2(next_node, adj_list, color, (currcolor == 1 ? 2 : 1)))
                return false;
        }} else if (color[next_node] == currcolor) {{
            return false;
        }}
    }}

    return true;
}}
    ]],
        {}
    )
)
table.insert(snippets, bipertite2)

local bfsgrid = s(
    "bfsgrid",
    fmt(
        [[
bool is_valid(int x, int y, vector<vector<{}>> &grid, vector<vector<bool>> &visited) {{
    return (x >= 0 && x < grid[0].size() && y >= 0 && y < grid.size() && !visited[y][x]){};
}}

bool bfs(int x, int y, vector<vector<{}>> &grid, vector<vector<bool>> &visited) {{
    queue<pair<int, int>> que;
    que.push({{x, y}});
    int currx = x;
    int curry = y;
    while (!que.empty()) {{
        pair<int, int> node = que.front();
        que.pop();
        currx = node.first;
        curry = node.second;

        // found case
        if (grid[curry][currx] == {}) {{
            return true;
        }}

        visited[curry][currx] = true;

        for (auto &[dirx, diry] : {}) {{
            int newX = currx + dirx;
            int newY = curry + diry;
            if (is_valid(newX, newY, grid, visited)) {{
                visited[newY][newX] = true;
                que.push({{newX, newY}});
            }}
        }}
    }}

    return false;
}}
    ]],
        {
            i(1, "/* type */"),
            i(2, "&& ()"),
            rep(1),
            i(3, "/* final value */"),
            c(4, {
                t "dir4",
                t "dir8",
            }),
        }
    )
)
table.insert(snippets, bfsgrid)

local dijkstra = s(
    "dijkstra",
    fmt(
        [[
vector<int> dijkstra(vector<vector<pair<int, int>>> &adj_list, int src) {{
    vector<int> dist(len(adj_list), INT_MAX);
    dist[src] = 0;

    priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> pq;
    pq.push({{0, src}});

    while (!pq.empty()) {{
        int currdist = pq.top().first;
        int currnode = pq.top().second;
        pq.pop();

        if (currdist > dist[currnode]) {{
            continue;
        }}

        for (auto &neighbour : adj_list[currnode]) {{
            int neighbour_node = neighbour.first;
            int weight = neighbour.second;

            int nextdist = currdist + weight;
            if (nextdist < dist[neighbour_node]) {{
                dist[neighbour_node] = nextdist;
                pq.push({{nextdist, neighbour_node}});
            }}
        }}
    }}

    return dist;
}}
    ]],
        {}
    )
)
table.insert(snippets, dijkstra)

local dijkstrapath = s(
    "dijkstrapath",
    fmt(
        [[
vector<pair<int, int>> dijkstra(vector<vector<pair<int, int>>> &adj_list, int src) {{
    vector<pair<int, int>> dist(len(adj_list), {{-1, INT_MAX}});
    dist[src] = {{-1, 0}};

    priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> pq;
    pq.push({{0, src}});

    while (!pq.empty()) {{
        int currdist = pq.top().first;
        int currnode = pq.top().second;
        pq.pop();

        if (currdist > dist[currnode].second) {{
            continue;
        }}

        for (auto &neighbour : adj_list[currnode]) {{
            int neighbour_node = neighbour.first;
            int weight = neighbour.second;

            int nextdist = currdist + weight;
            if (nextdist < dist[neighbour_node].second) {{
                dist[neighbour_node].second = nextdist;
                dist[neighbour_node].first = currnode;
                pq.push({{nextdist, neighbour_node}});
            }}
        }}
    }}

    return dist;
}}
    ]],
        {}
    )
)
table.insert(snippets, dijkstrapath)
-- End Refactoring --

return snippets, autosnippets
