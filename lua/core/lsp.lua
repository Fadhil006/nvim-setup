-- Neovim 0.11+ native LSP config

vim.lsp.config.clangd = {
  cmd = { "clangd", "--background-index" },
  filetypes = { "c", "cpp" },
  root_markers = { ".git", "compile_commands.json" },
}

vim.lsp.enable("clangd")

