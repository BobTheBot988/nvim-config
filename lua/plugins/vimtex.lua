return {
  "lervag/vimtex",
  lazy = false,
  init = function()
    -- 1. Use the "general" viewer method, NOT "okular"
    vim.g.vimtex_view_method = "general"

    -- 2. Set the "general_viewer" *command* to your full flatpak command
    vim.g.vimtex_view_general_viewer = "flatpak run org.kde.okular"

    -- 3. Pass the "general_options" that Okular needs for live-reload
    --    This is the magic part that makes live-reload work.
    vim.g.vimtex_view_general_options = "--unique file:@pdf#src:@line@tex"
  end,
}
