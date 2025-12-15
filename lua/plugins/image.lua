return {
  "3rd/image.nvim",
  -- You must explicitly set build = false if you use the magick_cli processor (recommended)
  build = false,
  dependencies = {
    "vhyrro/luarocks.nvim", -- Required if you want to use the 'magick_rock' processor
  },
  opts = {
    -- Set the processor to magick_cli, which uses the ImageMagick utility you installed.
    processor = "magick_cli",
    integrations = {
      -- This tells the plugin to automatically display images in Markdown files.
      markdown = {
        only_render_image_at_cursor = false, -- Set to true to only show the image when your cursor is on the link/tag
        only_render_image_at_cursor_mode = "popup", -- 'popup' or 'inline'
      },
    },
  },
  -- Lazy loading to only load the plugin when a relevant filetype is opened
  ft = { "markdown", "neorg", "tex", "jpg", "png", "jpeg", "gif" },
}
