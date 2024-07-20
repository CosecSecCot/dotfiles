#include <algorithm>
#include <array>
#include <cstring>
#include <deque>
#include <iostream>
#include <list>
#include <map>
#include <queue>
#include <set>
#include <stack>
#include <unordered_map>
#include <unordered_set>
#include <vector>
using namespace std;

/* * * * * * * * * * * * * * * * * * * * * DEBUG UTIL * * * * * * * * * * * * * * * * * * * *  */
template <typename T, typename = void> struct is_iterable : std::false_type {};
template <typename T>
struct is_iterable<T, std::void_t<decltype(std::begin(std::declval<T>())), decltype(std::end(std::declval<T>()))>>
    : std::true_type {};
template <typename T> inline constexpr bool is_iterable_v = is_iterable<T>::value;

inline void print_indent(int depth) {
        for (int i = 0; i < depth; ++i) {
                cerr << "  ";
        }
}

template <typename T> inline void _print(T t) {
        cerr << t;
}
inline void _print(char t) {
        cerr << '\'' << t << '\'';
}
inline void _print(string t) {
        cerr << '"' << t << '"';
}
inline void _print(const char *t) {
        cerr << '"' << t << '"';
}
inline void _print(bool t) {
        cerr << (t ? "true" : "false");
}
inline void _print(nullptr_t t) {
        cerr << "nullptr";
}

// For pairs
template <class T1, class T2> inline void _print(pair<T1, T2> p) {
        cerr << "( ";
        _print(p.first);
        cerr << ", ";
        _print(p.second);
        cerr << " )";
}

template <typename T> void _print_recursive(const T &container, int depth = 0, bool force_break = false) {
        if constexpr (is_iterable_v<T> && !std::is_same_v<T, std::string>) {
                cerr << "[";
                bool first = true;
                bool all_non_iterable = std::all_of(std::begin(container), std::end(container), [](const auto &elem) {
                        return !is_iterable_v<decltype(elem)> && !std::is_array_v<decltype(elem)>;
                });

                // Special case for vector<string>
                bool is_vector_of_strings = std::is_same_v<T, std::vector<std::string>>;

                if ((!all_non_iterable && !is_vector_of_strings) || force_break)
                        cerr << "\n";

                for (const auto &elem : container) {
                        if (!first) {
                                if ((all_non_iterable && !force_break) || is_vector_of_strings)
                                        cerr << ", ";
                                else
                                        cerr << ",\n";
                                // cerr << " ";
                        }
                        first = false;
                        if ((!all_non_iterable && !is_vector_of_strings) || force_break)
                                print_indent(depth + 1);
                        _print_recursive(elem, depth + 1, force_break && !is_vector_of_strings);
                }

                if ((!all_non_iterable && !is_vector_of_strings) || force_break) {
                        cerr << "\n";
                        print_indent(depth);
                }
                cerr << "]";
        } else {
                _print(container);
        }
}

template <typename T, size_t N> void _print_c_array(const T (&arr)[N], int depth = 0) {
        cerr << "[";
        if constexpr (std::is_array_v<T>) {
                // Multidimensional array
                cerr << "\n";
                for (size_t i = 0; i < N; ++i) {
                        if (i > 0)
                                cerr << ",\n";
                        print_indent(depth + 1);
                        _print_c_array(arr[i], depth + 1);
                }
                cerr << "\n";
                print_indent(depth);
        } else {
                // 1D array
                for (size_t i = 0; i < N; ++i) {
                        if (i > 0)
                                cerr << ", ";
                        _print(arr[i]);
                }
        }
        cerr << "]";
}

// For C-style arrays
template <typename T, size_t N> inline void _print(T (&arr)[N]) {
        _print_c_array(arr);
}

// For std::array
template <class T, size_t N> inline void _print(array<T, N> &a) {
        _print_recursive(a);
}

// For vector
template <class T> inline void _print(vector<T> v) {
        _print_recursive(v);
}

// For set and multiset
template <class T> inline void _print(set<T> s) {
        cerr << "{ ";
        for (auto it = s.begin(); it != s.end(); it++) {
                _print(*it);
                if (next(it) != s.end())
                        cerr << ", ";
        }
        cerr << " }";
}

// For unordered_set and unordered_multiset
template <class T> inline void _print(unordered_set<T> s) {
        cerr << "{ ";
        for (auto it = s.begin(); it != s.end(); it++) {
                _print(*it);
                if (next(it) != s.end())
                        cerr << ", ";
        }
        cerr << " }";
}

// For map and multimap
template <class T1, class T2> inline void _print(map<T1, T2> m) {
        cerr << "{\n";
        for (const auto &[key, value] : m) {
                cerr << "  ";
                _print(key);
                cerr << ": ";
                _print(value);
                cerr << "\n";
        }
        cerr << "}";
}

// For unordered_map and unordered_multimap
template <class T1, class T2> inline void _print(unordered_map<T1, T2> m) {
        cerr << "{\n";
        for (const auto &[key, value] : m) {
                cerr << "  ";
                _print(key);
                cerr << ": ";
                _print(value);
                cerr << "\n";
        }
        cerr << "}";
}

// For deque
template <class T> inline void _print(deque<T> d) {
        cerr << "[ ";
        for (auto i = 0; i < d.size(); i++) {
                _print(d[i]);
                if (i != d.size() - 1)
                        cerr << ", ";
        }
        cerr << " ]";
}

// For list
template <class T> inline void _print(list<T> l) {
        cerr << "[ ";
        for (const auto &i : l) {
                _print(i);
                if (&i != &l.back())
                        cerr << ", ";
        }
        cerr << " ]";
}

// For stack
template <class T> inline void _print(stack<T> s) {
        cerr << "[ ";
        stack<T> temp = s;
        while (!temp.empty()) {
                _print(temp.top());
                temp.pop();
                if (!temp.empty())
                        cerr << ", ";
        }
        cerr << " ]";
}

// For queue
template <class T> inline void _print(queue<T> q) {
        cerr << "[ ";
        queue<T> temp = q;
        while (!temp.empty()) {
                _print(temp.front());
                temp.pop();
                if (!temp.empty())
                        cerr << ", ";
        }
        cerr << " ]";
}

// For priority_queue
template <class T> inline void _print(priority_queue<T> pq) {
        cerr << "[ ";
        priority_queue<T> temp = pq;
        while (!temp.empty()) {
                _print(temp.top());
                temp.pop();
                if (!temp.empty())
                        cerr << ", ";
        }
        cerr << " ]";
}

template <typename... Args> void __dbg_print_args(Args... args) {
        ((cerr << args << " "), ...);
}

#define dbg(x, ...)                                                                                                    \
        cerr << #x << ": ";                                                                                            \
        _print(x);                                                                                                     \
        cerr << " ";                                                                                                   \
        __dbg_print_args(__VA_ARGS__);                                                                                 \
        cerr << '\n';
#define dbgp(...)                                                                                                      \
        __dbg_print_args(__VA_ARGS__);                                                                                 \
        cerr << '\n';
