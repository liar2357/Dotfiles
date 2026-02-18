return{
    "kkoomen/vim-doge",
    ft = { "python", "lua", "javascript", "go", "rust", "cpp" },
    build = ":call doge#install()", -- インストール実行
    config = function()
        vim.g["doge_doc_standard_python"] = "google"
    end,
}