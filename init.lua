require("core.options")
require("core.keymaps")
require("core.plugins")
require("core.lsp")
-- Load custom LuaSnip snippets
require("luasnip.loaders.from_lua").load({
        paths = vim.fn.stdpath("config") .. "/lua/snippets"
})
require("core.cmp")


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

-- ===== CursorLine underline (theme-safe, startup-safe) =====
local function set_cursorline()
        vim.opt.cursorline = true
        vim.opt.cursorlineopt = "line"
        vim.api.nvim_set_hl(0, "CursorLine", {
                underline = true,
                bg = "#2a2b3c",   -- soft dark background
        })
end

-- apply on startup
vim.api.nvim_create_autocmd("VimEnter", {
        callback = set_cursorline,
})

-- re-apply after any colorscheme change
vim.api.nvim_create_autocmd("ColorScheme", {
        callback = set_cursorline,
})

-----------------------------------------------------------
-- INDENTATION (8 SPACES)
-----------------------------------------------------------
vim.opt.tabstop = 8
vim.opt.shiftwidth = 8
vim.opt.softtabstop = 0
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.cindent = true

-----------------------------------------------------------
-- CTRL + S : AUTO-INDENT + SAVE (NO CURSOR JUMP)
-----------------------------------------------------------
vim.keymap.set({ "n", "i", "v" }, "<C-s>", function()
        local view = vim.fn.winsaveview()

        -- indent whole file without permanently moving cursor
        vim.cmd("silent! keepjumps normal! gg=G")

        vim.cmd("silent! write")
        vim.fn.winrestview(view)
end, { silent = true })


-----------------------------------------------------------
-- FOLDER NAVIGATION KEYMAPS
-----------------------------------------------------------

-- Open file explorer (netrw)
vim.keymap.set("n", "<leader>e", ":Ex<CR>", { silent = true })

-- Change cwd to current file's folder
vim.keymap.set("n", "<leader>cd", function()
        vim.cmd("cd %:p:h")
        print("CD → " .. vim.fn.getcwd())
end, { silent = true })

-- Jump to HOME directory
vim.keymap.set("n", "<leader>h", ":cd ~ | Ex<CR>", { silent = true })

-- Jump to CP folder (change path if needed)
vim.keymap.set("n", "<leader>cp", ":cd ~/cp | Ex<CR>", { silent = true })

-- Jump to Projects folder
vim.keymap.set("n", "<leader>pr", ":cd ~/projects | Ex<CR>", { silent = true })

-- <leader>p → copy absolute file path
vim.keymap.set("n", "<leader>p", function()
        vim.fn.setreg("+", vim.fn.expand("%:p"))
        print("File path copied")
end, { desc = "Copy file path" })

vim.keymap.set("n", "<leader>g", ":CompetiTest receive problem<CR>", { desc = "Receive tests" })
vim.keymap.set("n", "<leader>r", ":CompetiTest run<CR>", { desc = "Run tests" })
vim.keymap.set("n", "<leader>o", ":CompetiTest open<CR>", { desc = "Open tests" })

-- TAB = jump to next tabstop (even mid-line)
vim.keymap.set("i", "<Tab>", function()
        local col = vim.fn.col(".") - 1
        local ts = vim.opt.tabstop:get()
        local spaces = ts - (col % ts)
        return string.rep(" ", spaces)
end, { expr = true })

-- Shift-Tab = go back one tabstop
vim.keymap.set("i", "<S-Tab>", function()
        local col = vim.fn.col(".") - 1
        local ts = vim.opt.tabstop:get()
        local spaces = col % ts
        if spaces == 0 then spaces = ts end
        return string.rep("\b", spaces)
end, { expr = true })


-- =========================
-- Competitive Programming Timer
-- =========================

local cp_timer = {
        timer = nil,
        running = false,
        start_time = 0,
        elapsed = 0,
}

local function stop_timer()
        if cp_timer.timer then
                cp_timer.timer:stop()
                cp_timer.timer:close()
                cp_timer.timer = nil
        end
        cp_timer.running = false
end

local function start_timer()
        stop_timer() -- ensures RESET

        cp_timer.start_time = os.time()
        cp_timer.elapsed = 0
        cp_timer.timer = vim.loop.new_timer()

        cp_timer.timer:start(0, 1000, vim.schedule_wrap(function()
                cp_timer.elapsed = os.time() - cp_timer.start_time
                vim.cmd("redrawstatus")
        end))
        cp_timer.running = true
end

-- RESET + START (main CP key)
function _G.cp_timer_reset_start()
        start_timer()
        print("⏱️ CP Timer reset & started")
end

-- PAUSE / RESUME
function _G.cp_timer_toggle_pause()
        if not cp_timer.running then
                -- resume
                cp_timer.start_time = os.time() - cp_timer.elapsed
                cp_timer.timer = vim.loop.new_timer()


                cp_timer.timer:start(0, 1000, vim.schedule_wrap(function()
                        cp_timer.elapsed = os.time() - cp_timer.start_time
                        vim.cmd("redrawstatus")
                end))

                cp_timer.running = true
                print("⏱️ CP Timer resumed")
        else
                -- pause
                stop_timer()
                print("⏱️ CP Timer paused at " .. cp_timer.elapsed .. "s")
        end
end

-- STOP & CLEAR
function _G.cp_timer_stop()
        stop_timer()
        cp_timer.elapsed = 0
        print("⏱️ CP Timer stopped")
end

-- STATUSLINE
function _G.cp_timer_status()
        if cp_timer.elapsed > 0 then
                local m = math.floor(cp_timer.elapsed / 60)
                local s = cp_timer.elapsed % 60
                return string.format(" ⏱ %02d:%02d ", m, s)
        end
        return ""
end

vim.o.statusline = vim.o.statusline .. "%{%v:lua.cp_timer_status()%}"

-- KEYMAPS (CP friendly)
vim.keymap.set("n", "<leader>tt", cp_timer_reset_start, { desc = "CP Timer reset & start" })
vim.keymap.set("n", "<leader>tp", cp_timer_toggle_pause, { desc = "CP Timer pause/resume" })
vim.keymap.set("n", "<leader>ts", cp_timer_stop, { desc = "CP Timer stop" })

