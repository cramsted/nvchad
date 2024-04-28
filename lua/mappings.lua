require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
-- map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- select all
map('n', '<leader>V', 'ggVG', { desc = "Select All" })
-- find and replace all matching instances of selected text
map('v', '<C-r>', '"hy:%s/<C-r>h/<C-r>h/g<left><left>', { desc = "Find/Replace Selected Text" })
-- write shortcut
map({ 'n', 'v' }, '<leader>w', ":w<CR>", { desc = "Write Buffer" })
-- force quit vim/current window
map({ 'n', 'v' }, '<C-q>', ":q!<CR>")

-- LSP
map('n', '<leader>pi', ":LspInfo<CR>", { desc = "LS[P] [I]nfo" })
map('n', '<leader>pr', ":LspRestart<CR>", { desc = "LS[P] [R]estart" })
map('n', '<leader>ps', ":LspStart<CR>", { desc = "LS[P] [S]tart" })
map('n', '<leader>po', ":LspStop<CR>", { desc = "LS[P] St[O]p" })
map('n', '<leader>pl', ":LspLog<CR>", { desc = "LS[P] [L]og" })

-- Telescope
map('n', '<leader>fr', ':Telescope resume<CR>', { desc = '[F]ind [R]esume' })
-- map('n', '<leader>fm', ':Telescope notify<CR>', { desc = '[F]ind [M]essages' })

-- gen.lua
map({ 'n', 'v' }, '<leader>ia', ':Gen Ask<CR>', { desc = "A[I] [A]sk" })
map({ 'n', 'v' }, '<leader>ich', ':Gen Change<CR>', { desc = "A[I] [C]hange" })
map({ 'n', 'v' }, '<leader>icc', ':Gen Change_Code<CR>', { desc = "A[I] [C]hange [C]ode" })
map({ 'n', 'v' }, '<leader>ih', ':Gen Chat`<CR>', { desc = "A[I] C[h]at" })
map({ 'n', 'v' }, '<leader>iee', ':Gen Enhance_Code<CR>', { desc = "A[I] [E]nhance code" })
map({ 'n', 'v' }, '<leader>iew', ':Gen Enhance_Wording<CR>', { desc = "A[I] [E]nhace [W]ording" })
map({ 'n', 'v' }, '<leader>ieg', ':Gen Enhance_Grammar_Spelling<CR>', { desc = "A[I] [E]nhance [G]rammar" })
map({ 'n', 'v' }, '<leader>ig', ':Gen Generate<CR>', { desc = "A[I] [G]enerate" })
map({ 'n', 'v' }, '<leader>ir', ':Gen Review_Code<CR>', { desc = "A[I] [R]eview Code" })
map({ 'n', 'v' }, '<leader>is', ':Gen Summarize<CR>', { desc = "A[I] [S]ummarize" })

-- dap mappings
map("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>", { desc = "Add breakpoint at line" })
map("n", "<leader>dr", "<cmd> DapContinue <CR>", { desc = "Start or continue the debugger" })

-- -- vim-tmux-navigator
map({ "n", "v", "i" }, "<c-h>", "<cmd>TmuxNavigateLeft<cr>")
map({ "n", "v", "i" }, "<c-j>", "<cmd>TmuxNavigateDown<cr>")
map({ "n", "v", "i" }, "<c-k>", "<cmd>TmuxNavigateUp<cr>")
map({ "n", "v", "i" }, "<c-l>", "<cmd>TmuxNavigateRight<cr>")
map({ "n", "v", "i" }, "<c-\\>", "<cmd>TmuxNavigatePrevious<cr>")

-- LSP mappings
--  This function gets run when an LSP attaches to a particular buffer.
--    That is to say, every time a new file is opened that is associated with
--    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
--    function will be executed to configure the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  callback = function(event)
    -- NOTE: Remember that Lua is a real programming language, and as such it is possible
    -- to define small helper and utility functions so you don't have to repeat yourself.
    --
    -- In this case, we create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    -- Jump to the definition of the word under your cursor.
    --  This is where a variable was first declared, or where a function is defined, etc.
    --  To jump back, press <C-t>.
    map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

    -- Find references for the word under your cursor.
    map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

    -- Jump to the implementation of the word under your cursor.
    --  Useful when your language has ways of declaring types without an actual implementation.
    map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

    -- Jump to the type of the word under your cursor.
    --  Useful when you're not sure what type a variable is and you want to see
    --  the definition of its *type*, not where it was *defined*.
    map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

    -- Fuzzy find all the symbols in your current document.
    --  Symbols are things like variables, functions, types, etc.
    map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

    -- Fuzzy find all the symbols in your current workspace.
    --  Similar to document symbols, except searches over your entire project.
    map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    -- Rename the variable under your cursor.
    --  Most Language Servers support renaming across files, etc.
    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

    -- Execute a code action, usually your cursor needs to be on top of an error
    -- or a suggestion from your LSP for this to activate.
    map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    -- Opens a popup that displays documentation about the word under your cursor
    --  See `:help K` for why this keymap.
    map('K', vim.lsp.buf.hover, 'Hover Documentation')

    -- WARN: This is not Goto Definition, this is Goto Declaration.
    --  For example, in C this would take you to the header.
    map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    --    See `:help CursorHold` for information about when this is executed
    --
    -- When you move your cursor, the highlights will be cleared (the second autocommand).
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client.server_capabilities.documentHighlightProvider then
      local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })
    end

    -- The following autocommand is used to enable inlay hints in your
    -- code, if the language server you are using supports them
    --
    -- This may be unwanted, since they displace some of your code
    if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
      map('<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end, '[T]oggle Inlay [H]ints')
    end
  end,
})
