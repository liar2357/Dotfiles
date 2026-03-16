local is_nixos = vim.fn.filereadable("/etc/NIXOS") == 1

if is_nixos then
  return {}
end

return {

  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    config = function()
	    require("mason").setup({})
    end,
  },

}
