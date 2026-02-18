return{
  "nvim-treesitter/playground",
  cmd = "TSPlaygroundToggle",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("nvim-treesitter.configs").setup({ playground = { enable = true } })
  end,
}
