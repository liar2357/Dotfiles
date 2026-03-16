local is_nixos = vim.fn.filereadable("/etc/NIXOS") == 1

if is_nixos then
  return {}
end

return{
    "jay-babu/mason-null-ls.nvim",
    dependencies = { "mason.nvim", "none-ls.nvim" },
    config = function()
        require("mason-null-ls").setup({
            -- mason で ensure_installed を指定
            automatic_setup = false,  -- 自動セットアップをオフに
        })
    end,
}
