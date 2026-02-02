local function Map(mode, lhs, rhs, opts)
  local options = { noremap = true}
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end


Map('n','<C-s>',':w<CR>')
Map('n','<C-d>','<C-x>')
Map('n','<C-v>','"+p')
Map('n','p',']p')

Map('n','H','0')
Map('n','J','10j')
Map('n','K','10k')
Map('n','L','$')

Map('n','<CR>','o<Esc>')
Map('n','<S-CR>','<S-o><Esc>')
Map('n','<BS>','i<BS><Esc>')
Map('n','U','<C-r>')
Map('n','==',"gg=G''")

Map('i','jk','<Esc>')

Map('v','v','<C-v>')
Map('v','<C-c>','"+y')
Map('v','<C-x>','"+d')
Map('v',',','<Esc>ggVG')
Map('v','jk','<Esc>')

Map('v','H','0')
Map('v','J','10j')
Map('v','K','10k')
Map('v','L','$')

vim.keymap.set("n", "<leader>nf", function()
  vim.cmd("enew")      -- 空の新規バッファ
  vim.cmd("startinsert") -- すぐ入力モード
end, { desc = "New file (buffer)" })

Map('n','<C-w>v',':vs<CR>')
Map('n','<C-w>h',':sp<CR>')