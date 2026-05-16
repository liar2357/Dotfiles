vim.filetype.add({
  extension = {
    mdx = "mdx",
  },
})

-- mdx は markdown parser を使う
vim.treesitter.language.register("markdown", "mdx")
