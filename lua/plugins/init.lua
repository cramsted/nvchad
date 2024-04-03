return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre' -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  -- Debugging
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    event = "VeryLazy",
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end
  },
  {
    "nvim-neotest/nvim-nio"
  },
  {
    "mfussenegger/nvim-dap",
    -- config = function(_, _)
    --   require("nvchad.utils").load_mappings("dap")
    -- end
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap"
    },
    opts = {
      handlers = {},
    },
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "VeryLazy",
    opts = function()
      require "configs.null-ls"
    end,
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "selene",
        "clangd",
        "clang-format",
        "codelldb",
        "gopls",
        "nil",
        "texlab",
        "latexindent"
      },
    },
  },
  {
   'p00f/nvim-ts-rainbow'
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "cpp",
        "python",
        "json",
        "xml",
        "cmake",
        "c",
        "go",
        "gowork"
      },
    },
  },

  -- Non core functionality
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    -- NOTE: gets overwritten by NvChad, so defined in mappings
    -- keys = {
    --   { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
    --   { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
    --   { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
    --   { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
    --   { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    -- },
  },
  {
    "folke/todo-comments.nvim",
    lazy = false,
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup {
        vim.keymap.set("n", "]t", function()
          require("todo-comments").jump_next()
        end, { desc = "Next todo comment" }),

        vim.keymap.set("n", "[t", function()
          require("todo-comments").jump_prev()
        end, { desc = "Previous todo comment" }),

        vim.keymap.set("n", "<leader>ft", ":TodoTelescope<cr>",
          { desc = "[F]ind [T]odos" })
      }
    end
  },
  {
    "Pocco81/auto-save.nvim",
    lazy = false,
    config = function()
      require("auto-save").setup {
        -- your config goes here
        -- or just leave it empty :)
      }
    end,
  },
  {
    'tpope/vim-fugitive',
    lazy = false,
    config = function ()
      vim.keymap.set('n', '<leader>gh', ':diffget //3<CR>', {desc = "Git Get Diff on Right"})
      vim.keymap.set('n', '<leader>gf', ':diffget //2<CR>', {desc = "Git Get Diff on Left"})
      vim.keymap.set('n', '<leader>gs', ':G<CR>', {desc = "[G]it [S]tatus"})
      vim.keymap.set('n', '<leader>gc', ':G commit -m ""<left>', {desc = "[G]it [C]ommit"})
      vim.keymap.set('n', '<leader>gu', ':G push<CR>', {desc = "[G]it P[u]sh"})
    end
  },
  {
      "David-Kunz/gen.nvim",
      lazy = false,
      opts = {
          model = "mistral",      -- The default model to use.
          display_mode = "split", -- The display mode. Can be "float" or "split".
          show_prompt = true,    -- Shows the Prompt submitted to Ollama.
          show_model = true,     -- Displays which model you are using at the beginning of your chat session.
          -- Function to initialize Ollama
          command = "curl --silent --no-buffer -X POST http://localhost:11434/api/generate -d $body",
          -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
          -- This can also be a lua function returning a command string, with options as the input parameter.
          -- The executed command must return a JSON object with { response, context }
          -- (context property is optional).
          list_models = '<omitted lua function>', -- Retrieves a list of model names
          debug = false                           -- Prints errors and the command which is run.
      },
      -- config = function()
      -- end
  },
  {
    'ThePrimeagen/harpoon',
    lazy = false,
    config = function()
      vim.keymap.set({ 'n', 'v' }, '<leader>ma', function() require("harpoon.mark").add_file() end, { desc = "[M]arks [A]dd file" })
      vim.keymap.set({ 'n', 'v' }, '<leader>mm', function() require("harpoon.ui").toggle_quick_menu() end, { desc = "Open [M]arks [M]enu" })
      vim.keymap.set({ 'n', 'v' }, '<leader>mn', function() require("harpoon.ui").nav_next() end, { desc = "[M]arks [N]ext" })
      vim.keymap.set({ 'n', 'v' }, '<leader>mp', function() require("harpoon.ui").nav_prev() end, { desc = "[M]arks [P]revious" })

      vim.keymap.set({ 'n', 'v' }, '<leader>m1', function() require("harpoon.ui").nav_file(1) end, { desc = "[M]ark [F]ile 1" })
      vim.keymap.set({ 'n', 'v' }, '<leader>m2', function() require("harpoon.ui").nav_file(2) end, { desc = "[M]ark [F]ile 2" })
      vim.keymap.set({ 'n', 'v' }, '<leader>m3', function() require("harpoon.ui").nav_file(3) end, { desc = "[M]ark [F]ile 3" })
      vim.keymap.set({ 'n', 'v' }, '<leader>m4', function() require("harpoon.ui").nav_file(4) end, { desc = "[M]ark [F]ile 4" })
      vim.keymap.set({ 'n', 'v' }, '<leader>m5', function() require("harpoon.ui").nav_file(5) end, { desc = "[M]ark [F]ile 5" })
      vim.keymap.set({ 'n', 'v' }, '<leader>m6', function() require("harpoon.ui").nav_file(6) end, { desc = "[M]ark [F]ile 6" })
      vim.keymap.set({ 'n', 'v' }, '<leader>m7', function() require("harpoon.ui").nav_file(7) end, { desc = "[M]ark [F]ile 7" })
      vim.keymap.set({ 'n', 'v' }, '<leader>m8', function() require("harpoon.ui").nav_file(8) end, { desc = "[M]ark [F]ile 8" })
      vim.keymap.set({ 'n', 'v' }, '<leader>m9', function() require("harpoon.ui").nav_file(9) end, { desc = "[M]ark [F]ile 9" })
      vim.keymap.set({ 'n', 'v' }, '<leader>m0', function() require("harpoon.ui").nav_file(0) end, { desc = "[M]ark [F]ile 0" })
      require("harpoon").setup({
        menu = {
            width = vim.api.nvim_win_get_width(0) - 30,
        }
      })

    end
  },
  {
    'phaazon/hop.nvim',
    lazy = false,
    branch = 'v2', -- optional but strongly recommended
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
      local hop = require('hop')
      local directions = require('hop.hint').HintDirection
      vim.keymap.set('', 'f', function()
        hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
      end, {remap=true})
      vim.keymap.set('', 'F', function()
        hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
      end, {remap=true})
      vim.keymap.set('', '<leader>j', function()
        hop.hint_char1({  current_line_only = false})
      end, {remap=true, desc = "Hop to any char in buffer"})

    end
  },
  {
    "rcarriga/nvim-notify",
    lazy = false,
    config = function()
      vim.notify = require("notify")
    end
  },
  {
      "kylechui/nvim-surround",
      version = "*", -- Use for stability; omit to use `main` branch for the latest features
      event = "VeryLazy",
      config = function()
          require("nvim-surround").setup({
              -- Configuration here, or leave empty to use defaults
          })
      end
  },
  {
    "folke/trouble.nvim",
    lazy = false,
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  },
}
