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
