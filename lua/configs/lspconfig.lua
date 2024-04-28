-- EXAMPLE
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local util = require "lspconfig/util"

local servers = {
  lua_ls = {},
  -- clangd = {
    -- on_attach = on_attach,
    -- capabilities = capabilities,
    -- cmd = { "clangd" },
    -- filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
    -- root_dir = util.root_pattern(
    --   '.clangd',
    --   '.clang-tidy',
    --   '.clang-format',
    --   'compile_commands.json',
    --   'compile_flags.txt',
    --   'configure.ac',
    --   '.git'
    -- ),
    -- single_file_support = true
  -- },
  gopls = {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_dir = util.root_pattern("go.work", "go.mod", ".git"),
    settings = {
      gopls = {
        completeUnimported = true,
        usePlaceholders = true,
        analyses = {
          unusedparams = true,
        },
      },
    },
  },
  nil_ls = {},
  texlab = {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { "texlab" },
    filetypes = { "tex", "plaintex", "bib" },
    settings = {
      texlab = {
        auxDirectory = ".",
        bibtexFormatter = "texlab",
        build = {
          args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
          executable = "latexmk",
          forwardSearchAfter = false,
          onSave = true
        },
        chktex = {
          onEdit = false,
          onOpenAndSave = false
        },
        diagnosticsDelay = 300,
        formatterLineLength = 80,
        forwardSearch = {
          args = {}
        },
        latexFormatter = "latexindent",
        latexindent = {
          modifyLineBreaks = false
        }
      }
    }
  }
}

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

-- NOTE: the above forloop did not work for clangd
require'lspconfig'.clangd.setup{}

-- ***************
-- Examples
-- ***************
--
-- lspconfig.gopls.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   cmd = { "gopls" },
--   filetypes = { "go", "gomod", "gowork", "gotmpl" },
--   root_dir = util.root_pattern("go.work", "go.mod", ".git"),
--   settings = {
--     gopls = {
--       completeUnimported = true,
--       usePlaceholders = true,
--       analyses = {
--         unusedparams = true,
--       },
--     },
--   },
-- }

-- -- typescript
-- lspconfig.tsserver.setup {
--   on_attach = on_attach,
--   on_init = on_init,
--   capabilities = capabilities,
-- }
