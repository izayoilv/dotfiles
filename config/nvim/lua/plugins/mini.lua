return {
    {
        "echasnovski/mini.ai",
        event = "VeryLazy",
        config = function()
            require("mini.ai").setup({
                n_lines = 500,
            })
        end,
    },
    {
        "echasnovski/mini.bufremove",
        keys = {
            {
                "<leader>bd",
                function()
                    require("mini.bufremove").delete(0, false)
                end,
                desc = "Delete Buffer",
            },
            {
                "<leader>bD",
                function()
                    require("mini.bufremove").delete(0, true)
                end,
                desc = "Delete Buffer (Force)",
            },
        },
    },
}
