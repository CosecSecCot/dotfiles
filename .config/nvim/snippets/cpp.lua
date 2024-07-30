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
#include "bits/stdc++.h"
using namespace std;

void run_test() {{
        {}
}};

int main() {{
        ios::sync_with_stdio(false), cin.tie(nullptr), cout.tie(nullptr);
        int T = 1;
        cin >> T;
        while (T--) {{
                run_test();
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
            -- problem = f(function(_, snip)
            --     local res, env = {}, snip.env
            --     table.insert(res, env.TM_FILENAME_BASE)
            --     return res
            -- end),
            i(1, ""),
            -- i(2, ""),
        }
    )
)
table.insert(snippets, cc)

local boilerplate = s(
    "boilerplate",
    fmt(
        [[
    #include <bits/stdc++.h>
    using namespace std;

    {}

    int main() {{
        ios_base::sync_with_stdio(false), cin.tie(nullptr), cout.tie(nullptr);
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
        ios_base::sync_with_stdio(false), cin.tie(nullptr), cout.tie(nullptr);
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

local alle = s(
    "alle",
    fmt(
        [[
        {}.begin(), {}.end()
        ]],
        {
            i(1, ""),
            rep(1),
        }
    )
)
table.insert(snippets, alle)

local allr = s(
    "allr",
    fmt(
        [[
        {}.rbegin(), {}.rend()
        ]],
        {
            i(1, ""),
            rep(1),
        }
    )
)
table.insert(snippets, allr)

local mod = s(
    "mod",
    fmt(
        [[
        constexpr const int64_t MOD = {};
        ]],
        {
            i(1, "1000000007"),
        }
    )
)
table.insert(snippets, mod)

local debug = s(
    "debug",
    fmt(
        [[
#ifndef ONLINE_JUDGE
#include "bits/cosec-debug.h"
#else
#define dbg(x, ...)
#define dbgp(...)
#endif
        ]],
        {}
    )
)
table.insert(snippets, debug)

-- ## ALGORITHMS ##

local graphdirs = s(
    "graphdirs",
    fmt(
        [[
const vector<pair<int, int>> dir4 = {{{{0, -1}}, {{1, 0}}, {{0, 1}}, {{-1, 0}}}};
const vector<pair<int, int>> dir8 = {{{{0, -1}}, {{1, -1}}, {{1, 0}}, {{1, 1}}, {{0, 1}}, {{-1, 1}}, {{-1, 0}}, {{-1, -1}}}};
        ]],
        {}
    )
)
table.insert(snippets, graphdirs)

local graphinp = s(
    "graphinp",
    fmt(
        [[
    int n, m;
    cin >> n >> m;
    vector<vector<int>> graph(n + 1);
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

local dfsweighted = s(
    "dfsw",
    fmt(
        [[
void dfsw(int curr, vector<vector<pair<int, int>>> &adj_list, vector<bool> &visited{}) {{
    visited[curr] = true;
    {}
    for (auto next_node : adj_list[curr]) {{
        if (!visited[next_node.first]) {{
            dfsw(next_node.first, adj_list, visited);
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
table.insert(snippets, dfsweighted)

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

local graphcycledfs = s(
    "graphcycledfs",
    fmt(
        [[
bool graphcycledfs(int curr, vector<vector<int>> &adj_list, vector<bool> &visited, int currparent{}) {{
    visited[curr] = true;
    {}
    for (auto next_node : adj_list[curr]) {{
        if (!visited[next_node]) {{
            if (graphcycledfs(next_node, adj_list, visited, curr)) {{
                return true;
            }}
        }} else if (next_node != currparent) {{
            {}
            return true;
        }}
    }}
    return false;
}}
    ]],
        {
            i(1, ", /* parameters */"),
            i(2, "/* pre condition */"),
            i(3, "/* do something before return */"),
        }
    )
)
table.insert(snippets, graphcycledfs)

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

local bfsadj = s(
    "bfsadj",
    fmt(
        [[
void bfs(vector<vector<int>> &adj_list, int src, vector<bool> &visited) {{
    queue<int> q;
    q.push(src);

    visited[src] = true;

    while (!q.empty()) {{
        int curr = q.front();
        q.pop();
        // cout << currentNode << " ";

        for (int next_node : adj_list[curr]) {{
            if (!visited[next_node]) {{
                visited[next_node] = true;
                q.push(next_node);
            }}
        }}
    }}
}}
    ]],
        {}
    )
)
table.insert(snippets, bfsadj)

local dijkstra = s(
    "dijkstra",
    fmt(
        [[
vector<{}> dijkstra(vector<vector<pair<{}, {}>>> &adj_list, {} src) {{
    vector<{}> dist(len(adj_list), {});
    dist[src] = 0;

    priority_queue<pair<{}, {}>, vector<pair<{}, {}>>, greater<pair<{}, {}>>> pq;
    pq.push({{0, src}});

    while (!pq.empty()) {{
        {} currdist = pq.top().first;
        {} currnode = pq.top().second;
        pq.pop();

        if (currdist > dist[currnode]) {{
            continue;
        }}

        for (auto &neighbour : adj_list[currnode]) {{
            {} neighbour_node = neighbour.first;
            {} weight = neighbour.second;

            {} nextdist = currdist + weight;
            if (nextdist < dist[neighbour_node]) {{
                dist[neighbour_node] = nextdist;
                pq.push({{nextdist, neighbour_node}});
            }}
        }}
    }}

    return dist;
}}
    ]],
        {
            i(1, "int"),
            rep(1),
            rep(1),
            rep(1),
            rep(1),
            i(2, "INT_MAX"),
            rep(1),
            rep(1),
            rep(1),
            rep(1),
            rep(1),
            rep(1),
            rep(1),
            rep(1),
            rep(1),
            rep(1),
            rep(1),
        }
    )
)
table.insert(snippets, dijkstra)

local dijkstrapath = s(
    "dijkstrapath",
    fmt(
        [[
vector<pair<{}, {}>> dijkstra(vector<vector<pair<{}, {}>>> &adj_list, {} src) {{
    vector<pair<{}, {}>> dist(len(adj_list), {{-1, {}}});
    dist[src] = {{-1, 0}};

    priority_queue<pair<{}, {}>, vector<pair<{}, {}>>, greater<pair<{}, {}>>> pq;
    pq.push({{0, src}});

    while (!pq.empty()) {{
        {} currdist = pq.top().first;
        {} currnode = pq.top().second;
        pq.pop();

        if (currdist > dist[currnode].second) {{
            continue;
        }}

        for (auto &neighbour : adj_list[currnode]) {{
            {} neighbour_node = neighbour.first;
            {} weight = neighbour.second;

            {} nextdist = currdist + weight;
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
        {
            i(1, "int"),
            rep(1),
            rep(1),
            rep(1),
            rep(1),
            rep(1),
            rep(1),
            i(2, "INT_MAX"),
            rep(1),
            rep(1),
            rep(1),
            rep(1),
            rep(1),
            rep(1),
            rep(1),
            rep(1),
            rep(1),
            rep(1),
            rep(1),
        }
    )
)
table.insert(snippets, dijkstrapath)

local floyd = s(
    "floyd",
    fmt(
        [[
vector<vector<int>> floydWarshall(const vector<vector<pair<int, int>>> &graph) {{
    int n = graph.size();
    vector<vector<int>> dist(n, vector<int>(n, INT_MAX));
    for (int u = 1; u < n; u++) {{
        for (auto &[v, weight] : graph[u]) {{
            dist[u][v] = min(dist[u][v], weight);
        }}
    }}

    for (int u = 1; u < n; u++) {{
        dist[u][u] = 0;
    }}

    for (int k = 1; k < n; k++) {{
        for (int i = 1; i < n; i++) {{
            for (int j = 1; j < n; j++) {{
                if (dist[i][k] != INT_MAX && dist[k][j] != INT_MAX) {{
                    dist[i][j] = min(dist[i][j], dist[i][k] + dist[k][j]);
                }}
            }}
        }}
    }}

    return dist;
}}
    ]],
        {}
    )
)
table.insert(snippets, floyd)

local bellmanford = s(
    "bellmanford",
    fmt(
        [[
vector<ll> bellmanFord(vector<Edge> &edges, int n, int src, int &last) {{
    vector<ll> d(n + 1, LLONG_MAX);
    vector<int> p(n + 1, -1);
    d[src] = 0;
    int x = -1;
    for (int i = 0; i < n - 1; ++i) {{
        x = -1;
        for (const auto &e : edges) {{
            if (d[e.src] < LLONG_MAX) {{
                if (d[e.dest] > d[e.src] + e.weight) {{
                    d[e.dest] = max(LLONG_MIN, d[e.src] + e.weight);
                    p[e.dest] = e.src;
                    x = e.dest;
                }}
            }}
        }}
    }}

    last = x;

    // if (x == -1) {{
    // no cycles
    return d;
    // }}

    // not working exactly right
    //
    // int y = x;
    // for (int i = 0; i < n; ++i)
    //     y = p[y];
    //
    // vector<int> path;
    // for (int cur = y;; cur = p[cur]) {{
    //     path.push_back(cur);
    //     if (cur == y && path.size() > 1)
    //         break;
    // }}
    // reverse(all(path));
    //
    // cout << "Negative cycle: ";
    // for (int u : path)
    //     cout << u << ' ';
}}
    ]],
        {}
    )
)
table.insert(snippets, bellmanford)

local dsu = s(
    "dsu",
    fmt(
        [[
class DSU {{
private:
    vector<int> parent, sz;

public:
    DSU(int n) {{
        sz.resize(n + 1, 1);
        parent.resize(n + 1);
        iota(parent.begin(), parent.end(), 0);
    }}

    int find(int node) {{
        if (node == parent[node])
            return node;

        return parent[node] = find(parent[node]); // path compression
    }}

    void unite(int u, int v) {{
        int pu = find(u);
        int pv = find(v);
        if (pu == pv)
            return; // already connected

        if (sz[pu] < sz[pv]) {{
            parent[pu] = pv;
            sz[pv] += sz[pu];
        }} else {{
            parent[pv] = pu;
            sz[pu] += sz[pv];
        }}
    }}
}};
    ]],
        {}
    )
)
table.insert(snippets, dsu)

-- End Refactoring --

return snippets, autosnippets
