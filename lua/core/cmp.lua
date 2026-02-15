local cmp = require("cmp")
local luasnip = require("luasnip")

-- -------------------------
-- Completion source modes
-- -------------------------
local minimal_sources = {
  { name = "luasnip" },
}

local full_sources = {
  { name = "luasnip" },
  { name = "nvim_lsp" },
  { name = "buffer" },
  { name = "path" },
}

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  -- ❌ Disable auto popup
  completion = {
    autocomplete = false,
  },

  mapping = cmp.mapping.preset.insert({
    -- Snippet expand / jump
    ["<C-j>"] = cmp.mapping(function()
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      end
    end, { "i", "s" }),

    ["<C-k>"] = cmp.mapping(function()
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      end
    end, { "i", "s" }),

    -- 🔓 Manual full completion (on demand)
    ["<C-Space>"] = cmp.mapping(function()
      cmp.setup.buffer({ sources = full_sources })
      cmp.complete()
    end, { "i", "c" }),

    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),

  -- ✅ DEFAULT: snippets only
  sources = minimal_sources,

  formatting = {
    format = function(entry, item)
      item.menu = ({
        luasnip = "[SNIP]",
        nvim_lsp = "[LSP]",
        buffer = "[BUF]",
        path = "[PATH]",
      })[entry.source.name]
      return item
    end,
  },
})

-- 🔁 After completion closes → go back to snippets-only
cmp.event:on("menu_closed", function()
  cmp.setup.buffer({ sources = minimal_sources })
end)

