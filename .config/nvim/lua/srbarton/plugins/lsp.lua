return {
  'neovim/nvim-lspconfig',
  event = "BufEnter",
  config = function()
    -- Setup language servers.
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    local venv_path = os.getenv('VIRTUAL_ENV')
    local py_path = nil
    -- decide which python executable to use for mypy
    if venv_path ~= nil then
      py_path = venv_path .. "/bin/python3"
    else
      py_path = vim.g.python3_host_prog
    end
    local lspconfig = require('lspconfig')
    lspconfig.pylsp.setup {
      settings = {
        pylsp = {
          plugins = {
            black = { enables = true },
            pylsp_mypy = {
              enabled = true,
              overrides = { "--python-executable", py_path, true },
              report_progess = true,
              live_mode = false
            },
            jedi_completion = {
              fuzzy = true,
              include_params = true,
            },
          }
        }
      }
    }
    lspconfig.rust_analyzer.setup({
      capabilities = capabilities,
      filetypes = { "rust" },
      settings = {
        ['rust-analyzer'] = {
          cargo = {
            allFeatures = true,
          },
          check = {
            ignore = {
              "unused_imports",
              "unused_variables"
            }
          },
        },
      },
    })

    lspconfig.clangd.setup({
      filetypes = { "c", "cpp", "cc" },
      flags = {
        debounce_text_changes = 500,
      },
    })

    lspconfig.lua_ls.setup({
      settings = {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = "LuaJT"
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            -- also luasnip globals
            globals = { "vim",
              "ls",   -- require("luasnip")
              "s",    -- ls.snippet
              "sn",   -- ls.snippet_node
              "t",    -- ls.text_node
              "i",    -- ls.insert_node
              "f",    -- ls.function_node
              "d",    -- ls.dynamic_node
              "fmt",  -- require("luasnip.extras.fmt").fmt
              "fmta", -- require("luasnip.extras.fmt").fmta
              "rep",  -- require("luasnip.extras").rep
            },
          }
        }
      }
    })

    lspconfig.texlab.setup({
      -- config
    })

    lspconfig.ocamllsp.setup {}

    lspconfig.nixd.setup {}

    lspconfig.vhdl_ls.setup{}
    -- Global mappings.
    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

    -- Use LspAttach autocommand to only map the following keys
    -- after the language server attaches to the current buffer
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-x>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<Leader>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<Leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<Leader>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<Leader>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<Leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<Leader>f', function()
          vim.lsp.buf.format { async = true }
        end, opts)
      end,
    })
  end
}
