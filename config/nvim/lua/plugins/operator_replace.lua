return{
    "kana/vim-operator-replace",
    dependencies = { "kana/vim-operator-user" },
    keys = {
        { "_", "<Plug>(operator-replace)", mode = { "n", "x" } },
    },
}