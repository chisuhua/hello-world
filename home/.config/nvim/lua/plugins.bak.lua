-- ~/.config/nvim/lua/plugins.lua
return {
  -- 🔧 插件管理器 UI（可选）
  -- { "folke/lazy.nvim", cmd = "Lazy" },
    -- 🎨 主题
    {
    "sainnhe/gruvbox-material",
    lazy = false, -- 必须设为 false，确保启动时加载
    priority = 1000, -- 高优先级，确保尽早加载 colorscheme
    config = function()
      vim.g.gruvbox_material_background = 'hard'   -- 可选: soft, medium, hard
      vim.g.gruvbox_material_foreground = 'original' -- 可选: original, mix, lighter
      vim.g.gruvbox_material_enable_italic = true
      vim.g.gruvbox_material_diagnostic_virtual_text = 'colored' -- LSP 诊断颜色优化

      -- 应用配色方案
      vim.cmd('colorscheme gruvbox-material')
    end,
  },
	{
	  "numToStr/Comment.nvim",
	  event = "VeryLazy",
	  config = true,
	},
  -- 🧠 AI 补全
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = { accept = "<C-l>" },
        },
        panel = { enabled = false },
      })
    end,
  },
  -- 🌳 文件树
  {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("nvim-tree").setup({})  -- ← 必须有这一行！
  end,
  keys = { { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file tree" } }
  },
  {
    "GeorgesAlkhouri/nvim-aider",
    cmd = "Aider",
    -- Example key mappings for common actions:
    keys = {
      { "<leader>a/", "<cmd>Aider toggle<cr>", desc = "Toggle Aider" },
      { "<leader>as", "<cmd>Aider send<cr>", desc = "Send to Aider", mode = { "n", "v" } },
      { "<leader>ac", "<cmd>Aider command<cr>", desc = "Aider Commands" },
      { "<leader>ab", "<cmd>Aider buffer<cr>", desc = "Send Buffer" },
      { "<leader>a+", "<cmd>Aider add<cr>", desc = "Add File" },
      { "<leader>a-", "<cmd>Aider drop<cr>", desc = "Drop File" },
      { "<leader>ar", "<cmd>Aider add readonly<cr>", desc = "Add Read-Only" },
      { "<leader>aR", "<cmd>Aider reset<cr>", desc = "Reset Session" },
      -- Example nvim-tree.lua integration if needed
      { "<leader>a+", "<cmd>AiderTreeAddFile<cr>", desc = "Add File from Tree to Aider", ft = "NvimTree" },
      { "<leader>a-", "<cmd>AiderTreeDropFile<cr>", desc = "Drop File from Tree from Aider", ft = "NvimTree" },
    },
    dependencies = {
      { "folke/snacks.nvim", version = ">=2.24.0" },
      --- The below dependencies are optional
      "catppuccin/nvim",
      -- "nvim-tree/nvim-tree.lua",
      --- Neo-tree integration
      {
        "nvim-neo-tree/neo-tree.nvim",
        opts = function(_, opts)
          -- Example mapping configuration (already set by default)
          -- opts.window = {
          --   mappings = {
          --     ["+"] = { "nvim_aider_add", desc = "add to aider" },
          --     ["-"] = { "nvim_aider_drop", desc = "drop from aider" }
          --     ["="] = { "nvim_aider_add_read_only", desc = "add read-only to aider" }
          --   }
          -- }
          require("nvim_aider.neo_tree").setup(opts)
        end,
      },
    },
    config = true,
  },
  {
  "NickvanDyke/opencode.nvim",
	  dependencies = {
	    -- Recommended for `ask()` and `select()`.
	    -- Required for `snacks` provider.
	    ---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
	    { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
	  },
	  config = function()
	    ---@type opencode.Opts
	    vim.g.opencode_opts = {
	      -- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition" on the type or field.
	    }

	    -- Required for `opts.events.reload`.
	    vim.o.autoread = true

	    -- Recommended/example keymaps.
	    vim.keymap.set({ "n", "x" }, "<C-a>", function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "Ask opencode…" })
	    vim.keymap.set({ "n", "x" }, "<C-x>", function() require("opencode").select() end,                          { desc = "Execute opencode action…" })
	    vim.keymap.set({ "n", "t" }, "<C-.>", function() require("opencode").toggle() end,                          { desc = "Toggle opencode" })

	    vim.keymap.set({ "n", "x" }, "go",  function() return require("opencode").operator("@this ") end,        { desc = "Add range to opencode", expr = true })
	    vim.keymap.set("n",          "gol", function() return require("opencode").operator("@this ") .. "_" end, { desc = "Add line to opencode", expr = true })

	    vim.keymap.set("n", "<S-C-u>", function() require("opencode").command("session.half.page.up") end,   { desc = "Scroll opencode up" })
	    vim.keymap.set("n", "<S-C-d>", function() require("opencode").command("session.half.page.down") end, { desc = "Scroll opencode down" })

	    -- You may want these if you stick with the opinionated "<C-a>" and "<C-x>" above — otherwise consider "<leader>o…".
	    vim.keymap.set("n", "+", "<C-a>", { desc = "Increment under cursor", noremap = true })
	    vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement under cursor", noremap = true })
	  end,
  },

  -- 🔍 模糊查找
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-frecency.nvim", -- 可选：高频文件
    },
    cmd = "Telescope",
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help" },
    },
    config = function()
      require("telescope").setup({
        extensions = {
          frecency = { show_scores = false, show_unindexed = true }
        }
      })
      require("telescope").load_extension("frecency")
    end,
  },

  -- 🧩 LSP + DAP + Mason
  {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = { "clangd" },
      handlers = {
        -- 全局默认 handler
        function(server_name)
          require("lspconfig")[server_name].setup({ capabilities = capabilities })
        end,
        -- clangd 特定配置
        clangd = function()
          require("lspconfig").clangd.setup({
            capabilities = capabilities,
            cmd = { "clangd", "--background-index", "--compile-commands-dir=build" },
            -- 可选：启用 inlay hints（Neovim 0.10+）
            init_options = {
              clangd = {
                hints = { parameters = true, deducedTypes = true }
              }
            }
          })
        end,
      },
    })
  end,
  }, 
  -- 💡 补全引擎
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "zbirenbaum/copilot-cmp",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      cmp.setup({
        snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
        mapping = cmp.mapping.preset.insert({
          ["<C-l>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "copilot" },
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },

  -- 🛠️ 格式化
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          cpp = { "clang-format" },
          c = { "clang-format" },
        },
        format_on_save = { timeout_ms = 1000 },
      })
    end,
  },

  -- 🐞 调试
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = { command = "codelldb", args = { "--port", "${port}" } },
      }
      dap.configurations.cpp = {
        {
          name = "Launch",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        }
      }
      dap.configurations.c = dap.configurations.cpp
    end,
    keys = {
      { "<F5>", "<cmd>lua require'dap'.continue()<cr>", desc = "Debug: Start/Continue" },
      { "<F10>", "<cmd>lua require'dap'.step_over()<cr>", desc = "Debug: Step Over" },
      { "<F11>", "<cmd>lua require'dap'.step_into()<cr>", desc = "Debug: Step Into" },
      { "<F12>", "<cmd>lua require'dap'.step_out()<cr>", desc = "Debug: Step Out" },
      { "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", desc = "Debug: Toggle Breakpoint" },
    },
  },

  -- 🌲 Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "VeryLazy",
    config = function()
      require("nvim-treesitter.config").setup({
        ensure_installed = { "c", "cpp", "cmake", "bash"},
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
        },
      })
    end,
  },
-- 🔑 快捷键提示
{
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300  -- 保持 300ms 响应速度
  end,
  config = function()
    local wk = require("which-key")
    wk.setup({
      -- 可选：增强视觉体验
      -- icons = { group = "", separator = "" },
      -- layout = { spacing = 4 },
    })

    -- ✅ 第一步：注册所有主分组（含新增的 window 分组）
    wk.register({
      c = { name = "+Code" },       -- LSP/代码操作
      g = { name = "+Git" },        -- Git 集成
      f = { name = "+Find" },       -- 模糊查找
      d = { name = "+Debug" },      -- 调试
      s = { name = "+Symbols" },    -- 符号导航
      a = { name = "+AI" },         -- AI 工具
      t = { name = "+Tabs" },       -- 标签页
      w = { name = "+Window" },     -- ✅ 新增：窗口管理分组
      b = { name = "+Buffers" },    -- ✅ 新增：缓冲区管理
    }, { prefix = "<leader>" })

    -- ✅ 第二步：注册具体命令（关键：窗口命令必须用 <leader>w 作为前缀）
    wk.register({
      -- 核心操作
      ["<leader>q"] = { "<cmd>q<cr>", "Quit" },
      ["<leader>e"] = { "<cmd>NvimTreeToggle<cr>", "Toggle file tree" },
      
      -- ✅ 窗口管理（必须归属到 <leader>w 分组）
      ["<leader>wv"] = { "<C-w>v", "Split vertical" },
      ["<leader>ws"] = { "<C-w>s", "Split horizontal" },
      ["<leader>wc"] = { "<C-w>c", "Close window" },
      ["<leader>w="] = { "<C-w>=", "Equalize sizes" },
      
      -- 缓冲区管理
      ["<leader>bb"] = { "<cmd>Telescope buffers<cr>", "Switch buffer" },
      ["<leader>bd"] = { "<cmd>bd<cr>", "Close buffer" },
      
      -- 保留原有符号/调试等命令
      ["<leader>sw"] = { "<cmd>lua vim.lsp.buf.workspace_symbol()<cr>", "Workspace symbols" },
      ["<leader>sd"] = { "<cmd>lua vim.lsp.buf.document_symbol()<cr>", "Document symbols" },
      ["<leader>st"] = { "<cmd>Telescope lsp_document_symbols<cr>", "Doc symbols (TS)" },
      ["<leader>sT"] = { "<cmd>Telescope lsp_workspace_symbols<cr>", "Workspace symbols (TS)" },
      ["<leader>gd"] = { "<cmd>DiffviewOpen<cr>", "Git diff" },
      ["<leader>gh"] = { "<cmd>DiffviewFileHistory %<cr>", "File history" },
      ["<leader>gb"] = { "<cmd>GitBlameToggle<cr>", "Git blame" },
      ["<leader>aa"] = { "<cmd>ToggleTerm direction=float<cr>", "Aider terminal" },
      ["<leader>tn"] = { "<cmd>tabnew<cr>", "New tab" },
      ["<leader>tc"] = { "<cmd>tabclose<cr>", "Close tab" },
      ["<leader>to"] = { "<cmd>tabonly<cr>", "Close other tabs" },
      ["<leader>t["] = { "<cmd>tabprevious<cr>", "Prev tab" },
      ["<leader>t]"] = { "<cmd>tabnext<cr>", "Next tab" },
    })
  end,
},
  -- 📊 Git 集成
  {
    "lewis6991/gitsigns.nvim",
    event = "BufRead",
    config = true,
  },
  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
  },
  {
    "f-person/git-blame.nvim",
    event = "BufRead",
    config = function()
      vim.g.gitblame_enabled = 0
    end,
  },
}
