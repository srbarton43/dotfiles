return {
  'hrsh7th/nvim-cmp',
  event = "InsertEnter",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-omni",
    "saadparwaiz1/cmp_luasnip",
    "neovim/nvim-lspconfig",
    "L3MON4D3/LuaSnip",
    "onsails/lspkind-nvim",
    "hrsh7th/cmp-cmdline",
  },
  config = function()
    -- Setup nvim-cmp.
    local cmp = require("cmp")
    local lspkind = require("lspkind")
    local luasnip = require("luasnip")

    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end
      },
      mapping = cmp.mapping.preset.insert {
        ["<Tab>"] = function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end,
        ["<S-Tab>"] = function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end,
        ["<CR>"] = cmp.mapping.confirm { select = true },
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<Esc>"] = cmp.mapping.close(),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),

        ['<C-f>'] = cmp.mapping(function(fallback)
          if luasnip.jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<C-b>'] = cmp.mapping(function(fallback)
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      },
      sources = {
        { name = "nvim_lsp" },               -- For nvim-lsp
        { name = "luasnip", option = { use_show_condition = false } },
        { name = "path" },                   -- for path completion
        { name = "buffer",  keyword_length = 2 }, -- for buffer word completion
        { name = "emoji",   insert = true }, -- emoji completion
      },
      completion = { keyword_length = 1, completeopt = "menu, menuone, noselect", },
      view = {
        entries = "custom",
      },
      formatting = {
        format = lspkind.cmp_format {
          mode = "symbol_text",
          menu = {
            nvim_lsp = "[LSP]",
            luasnip = "[Snip]",
            nvim_lua = "[Lua]",
            path = "[Path]",
            buffer = "[Buffer]",
            emoji = "[Emoji]",
            omni = "[Omni]",
          },
        },
      },
    }

    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' }
      }
    })

    -- `:` cmdline setup.
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' }
      }, {
        {
          name = 'cmdline',
          option = {
            ignore_cmds = { 'Man', '!' }
          }
        }
      })
    })

    --  see https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#how-to-add-visual-studio-code-dark-theme-colors-to-the-menu
    vim.cmd([[
  highlight! link CmpItemMenu Comment
  " gray
  highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
  " blue
  highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
  highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6
  " light blue
  highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
  highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE
  highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE
  " pink
  highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
  highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0
  " front
  highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
  highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4
  highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4
]])
  end,
}
