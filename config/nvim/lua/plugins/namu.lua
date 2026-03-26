return {
  "bassamsdata/namu.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("namu").setup()
    vim.diagnostic.config({
      virtual_text = false,
    })
  end,
}

