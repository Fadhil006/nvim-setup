local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

  -- ======================
  -- CompetiTest
  -- ======================
  {
    "xeluxee/competitest.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    config = function()
      require("competitest").setup({
        received_problems_path =
          "/home/fadhil/SublimeUser/Main/neovim/$(PROBLEM).$(FEXT)",
        received_contests_directory =
          "/home/fadhil/SublimeUser/Main/neovim",
        received_contests_problems_path = "$(PROBLEM).$(FEXT)",
        open_received_problems = true,
        template_file = {
          cpp = vim.fn.expand("~/.config/nvim/templates/cpp.cpp"),
        },
      })
    end,
  },

  -- ======================
  -- Auto pairs
  -- ======================
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },

  -- ======================
  -- File tree
  -- ======================
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = {
          side = "right",
          width = 30,
        },
        filters = {
          dotfiles = false,
        },
      })
    end,
  },

  -- ======================
  -- Treesitter
  -- ======================
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "cpp", "c", "lua" },
        highlight = { enable = true },
      })
    end,
  },

  -- ======================
  -- Theme
  -- ======================
{
  "catppuccin/nvim",
  name = "catppuccin",
  config = function()
    require("catppuccin").setup({
      transparent_background = true,
    })
    vim.cmd.colorscheme("catppuccin")
  end,
},
})
