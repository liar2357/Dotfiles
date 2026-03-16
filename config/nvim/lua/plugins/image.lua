return{
  "3rd/image.nvim",
  build = false,
  opts = {
    processor = "magick_cli",
  },
  opts = {
    backend = "kitty",
    integrations = {
      markdown = {
        enabled = true,
        clear_in_insert_mode = false,
      },
    },
  },
}
