require("core.options")
require("core.keymaps")
require("core.plugins")
require("core.lsp")

vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*.cpp",
  callback = function()
    local marker = "// CURSOR_HERE"
    local row = vim.fn.search(marker)
    if row > 0 then
      vim.api.nvim_win_set_cursor(0, { row, 0 })
      vim.cmd("normal! ^")
      vim.cmd("normal! dd") -- remove marker line
    end
  end,
})
