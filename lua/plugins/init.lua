return {
  { "LazyVim/LazyVim", opts = { colorscheme = "doom-one" } },

  {
    "folke/snacks.nvim",
    -- Set priority high and lazy to false to ensure it loads first
    priority = 1000,
    lazy = false,
    opts = {
      notifier = {
        timeout = 4000, -- default timeout in ms
      },
      styles = {
        notification = {
          -- Keep other settings, but override 'wrap'
          wo = {
            wrap = true, -- <--- Force wrapping for the notification style
          },
        },
      },
      picker = {
        -- This option ensures the override happens
        enabled = true,
        gh = true,
        ui_select = true,
        -- other options...
      },
    },
  },
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = {},
  },

  {
    "mrcjkb/rustaceanvim",
    version = "^6", -- Recommended
    lazy = false, -- This plugin is already lazy
    ft = "rust",
    config = function()
      local extension_path = "/var/home/robTheBob/.local/share/nvim/mason/bin/codelldb" .. "/extension/"
      local codelldb_path = extension_path .. "adapter/codelldb"
      local liblldb_path = extension_path .. "lldb/lib/liblldb.so"
      -- If you are on Linux, replace the line above with the line below:
      -- local liblldb_path = extension_path .. "lldb/lib/liblldb.so"
      local cfg = require("rustaceanvim.config")

      vim.g.rustaceanvim = {
        server = {
          cmd = function()
            return { "/var/home/robTheBob/.cargo/bin/rust-analyzer" }
          end,
        },
        dap = {
          adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
        },
      }
    end,
  },

  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },

  {
    "mfussenegger/nvim-dap",
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
    end,
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      require("dapui").setup()
    end,
  },

  {
    "saecki/crates.nvim",
    ft = { "toml" },
    config = function()
      require("crates").setup({
        completion = {
          cmp = {
            enabled = true,
          },
        },
      })
      require("cmp").setup.buffer({
        sources = { { name = "crates" } },
      })
    end,
  },
  --  "rcarriga/nvim-notify", -- optional
  --"stevearc/dressing.nvim", -- optional, UI for :JupyniumKernelSelect
  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
