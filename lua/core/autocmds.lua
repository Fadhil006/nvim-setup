local vim = vim
local api = vim.api

api.nvim_create_augroup("ConfigAutoGit", { clear = true })
api.nvim_create_autocmd("BufWritePost", {
    group = "ConfigAutoGit",
    pattern = vim.fn.expand("~/.config/nvim") .. "/*",
    callback = function()
        local nvim_dir = vim.fn.expand("~/.config/nvim")
        -- run async to prevent freezing neovim
        vim.system({ "git", "add", "." }, { cwd = nvim_dir }, function()
            vim.system({ "git", "commit", "-m", "Auto-update config on save" }, { cwd = nvim_dir }, function()
                vim.system({ "git", "push" }, { cwd = nvim_dir }, function(out)
                    vim.schedule(function()
                        if out.code == 0 then
                            print("Config auto-pushed to GitHub!")
                        end
                    end)
                end)
            end)
        end)
    end
})
