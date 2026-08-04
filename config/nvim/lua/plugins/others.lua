return {
    {
        "brenoprata10/nvim-highlight-colors",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("nvim-highlight-colors").setup({})
        end,
    },
    {
        "echasnovski/mini.comment",
        event = "VeryLazy",
        opts = {},
    },
    {
        -- mini.comment can't handle JSX/TSX & embedded-language commentstrings
        "folke/ts-comments.nvim",
        event = "VeryLazy",
        opts = {},
    },
}
