return {
  {
    "dmtrKovalenko/fff.nvim",
    build = function()
      -- this will download prebuild binary or try to use existing rustup toolchain to build from source
      -- (if you are using lazy you can use gb for rebuilding a plugin if needed)
      require("fff.download").download_or_build_binary()
    end,
    -- if you are using nixos
    -- build = "nix run .#release",
    opts = { -- (optional)
      debug = {
        enabled = false, -- we expect your collaboration at least during the beta
        show_scores = true, -- to help us optimize the scoring system, feel free to share your scores!
      },
    },
    -- No need to lazy-load with lazy.nvim.
    -- This plugin initializes itself lazily.
    lazy = false,
    keys = {
      {
        "ff", -- try it if you didn't it is a banger keybinding for a picker
        function()
          require("fff").find_files()
        end,
        desc = "FFFind files",
      },
    },
    config = function()
      require("fff").setup({
        base_path = vim.fn.getcwd(),
        prompt = "🦆 ",
        title = "FFFiles",
        max_results = 100,
        max_threads = 4,
        lazy_sync = true, -- set to false if you want file indexing to start on open
        layout = {
          height = 0.8,
          width = 0.8,
          prompt_position = "bottom", -- or 'top'
          preview_position = "right", -- or 'left', 'right', 'top', 'bottom'
          preview_size = 0.5,
        },
        preview = {
          enabled = true,
          max_size = 10 * 1024 * 1024, -- Do not try to read files larger than 10MB
          chunk_size = 8192, -- Bytes per chunk for dynamic loading (8kb - fits ~100-200 lines)
          binary_file_threshold = 1024, -- amount of bytes to scan for binary content (set 0 to disable)
          imagemagick_info_format_str = "%m: %wx%h, %[colorspace], %q-bit",
          line_numbers = false,
          wrap_lines = false,
          show_file_info = true,
          filetypes = {
            svg = { wrap_lines = true },
            markdown = { wrap_lines = true },
            text = { wrap_lines = true },
          },
        },
        keymaps = {
          close = "<Esc>",
          select = "<CR>",
          select_split = "<C-s>",
          select_vsplit = "<C-v>",
          select_tab = "<C-t>",
          -- you can assign multiple keys to any action
          move_up = { "<Up>", "<C-p>" },
          move_down = { "<Down>", "<C-n>" },
          preview_scroll_up = "<C-u>",
          preview_scroll_down = "<C-d>",
          toggle_debug = "<F2>",
          -- goes to the previous query in history
          cycle_previous_query = "<C-Up>",
          -- multi-select keymaps for quickfix
          toggle_select = "<Tab>",
          send_to_quickfix = "<C-q>",
        },
        hl = {
          border = "FloatBorder",
          normal = "Normal",
          cursor = "CursorLine",
          matched = "IncSearch",
          title = "Title",
          prompt = "Question",
          active_file = "Visual",
          frecency = "Number",
          debug = "Comment",
          combo_header = "Number",
          -- Multi-select highlights
          selected = "FFFSelected",
          selected_active = "FFFSelectedActive",
          -- Git text highlights for file names
          git_staged = "FFFGitStaged",
          git_modified = "FFFGitModified",
          git_deleted = "FFFGitDeleted",
          git_renamed = "FFFGitRenamed",
          git_untracked = "FFFGitUntracked",
          git_ignored = "FFFGitIgnored",
          -- Git sign/border highlights
          git_sign_staged = "FFFGitSignStaged",
          git_sign_modified = "FFFGitSignModified",
          git_sign_deleted = "FFFGitSignDeleted",
          git_sign_renamed = "FFFGitSignRenamed",
          git_sign_untracked = "FFFGitSignUntracked",
          git_sign_ignored = "FFFGitSignIgnored",
          -- Git sign selected highlights
          git_sign_staged_selected = "FFFGitSignStagedSelected",
          git_sign_modified_selected = "FFFGitSignModifiedSelected",
          git_sign_deleted_selected = "FFFGitSignDeletedSelected",
          git_sign_renamed_selected = "FFFGitSignRenamedSelected",
          git_sign_untracked_selected = "FFFGitSignUntrackedSelected",
          git_sign_ignored_selected = "FFFGitSignIgnoredSelected",
        },
        -- Store file open frecency
        frecency = {
          enabled = true,
          db_path = vim.fn.stdpath("cache") .. "/fff_nvim",
        },
        -- Store successfully opened queries with respective matches
        history = {
          enabled = true,
          db_path = vim.fn.stdpath("data") .. "/fff_queries",
          min_combo_count = 3, -- file will get a boost if it was selected 3 in a row times per specific query
          combo_boost_score_multiplier = 100, -- Score multiplier for combo matches
        },
        debug = {
          enabled = false, -- Set to true to show scores in the UI
          show_scores = false,
        },
        logging = {
          enabled = true,
          log_file = vim.fn.stdpath("log") .. "/fff.log",
          log_level = "info",
        },
      })
    end,
  },
}
