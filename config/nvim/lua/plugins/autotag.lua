return {
    "windwp/nvim-ts-autotag",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "InsertEnter",
    opts = {
        -- New setup layout: general options go under `opts`
        opts = {
            enable_close = true,
            enable_rename = true,
            enable_close_on_slash = false,
        },
    },
}
