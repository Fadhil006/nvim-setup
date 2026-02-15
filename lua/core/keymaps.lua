vim.g.mapleader = " "

-- INSERT → NORMAL
vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("i", "Jj", "<Esc>")
vim.keymap.set("i", "jJ", "<Esc>")

-- Save
vim.keymap.set("n", "<leader>w", ":w<CR>")

-- Run C++ code
vim.keymap.set("n", "<leader>r", ":w<CR>:!g++ % -O2 -std=gnu++17 && ./a.out < input.txt > output.txt<CR>")

-- Copy whole code
vim.keymap.set("n", "<leader>c", "ggVGy")

-- Quit
vim.keymap.set("n", "<leader>q", ":q<CR>")

-- file tree
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- ======================
-- CP TEMPLATE COMMANDS
-- ======================

local function insert_lines(lines)
  vim.api.nvim_buf_set_lines(0, 0, -1, false, {})
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
  vim.api.nvim_win_set_cursor(0, { #lines - 6, 0 })
end

-- :cd → template WITH testcases
vim.api.nvim_create_user_command("Cd", function()
  insert_lines({
    "#include <bits/stdc++.h>",
    "using namespace std;",
    "",
    "#define fastIO() ios::sync_with_stdio(false); cin.tie(nullptr)",
    "#define ll long long",
    "#define all(x) (x).begin(), (x).end()",
    "#define sz(x) int((x).size())",
    "#define nl '\\n'",
    "",
    "template<class T>",
    "istream& operator>>(istream &is, vector<T> &v) {",
    "    for (auto &x : v) is >> x;",
    "    return is;",
    "}",
    "",
    "template<class T>",
    "ostream& operator<<(ostream &os, const vector<T> &v) {",
    "    for (int i = 0; i < sz(v); i++) os << v[i] << (i + 1 < sz(v) ? ' ' : '\\n');",
    "    return os;",
    "}",
    "",
    "int main() {",
    "    fastIO();",
    "    int t = 1;",
    "    cin >> t;",
    "    while (t--) {",
    "        ",
    "    }",
    "}",
    "",
    "/*",
    "Notes:",
    "*/",
  })
end, {})

-- :cc → template WITHOUT testcases
vim.api.nvim_create_user_command("Cc", function()
  insert_lines({
    "#include <bits/stdc++.h>",
    "using namespace std;",
    "",
    "#define fastIO() ios::sync_with_stdio(false); cin.tie(nullptr)",
    "#define ll long long",
    "#define all(x) (x).begin(), (x).end()",
    "#define sz(x) int((x).size())",
    "#define nl '\\n'",
    "",
    "template<class T>",
    "istream& operator>>(istream &is, vector<T> &v) {",
    "    for (auto &x : v) is >> x;",
    "    return is;",
    "}",
    "",
    "template<class T>",
    "ostream& operator<<(ostream &os, const vector<T> &v) {",
    "    for (int i = 0; i < sz(v); i++) os << v[i] << (i + 1 < sz(v) ? ' ' : '\\n');",
    "    return os;",
    "}",
    "",
    "int main() {",
    "    fastIO();",
    "    ",
    "}",
    "",
    "/*",
    "Notes:",
    "*/",
  })
end, {})

