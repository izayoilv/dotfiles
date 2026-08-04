return {
    "folke/flash.nvim",
    event = "VeryLazy",
    keys = {
        {
            "s",
            mode = {
                "n",
                "o",
            },
            function()
                require("flash").jump()
            end,
            desc = "Flash",
        },
        {
            "S",
            mode = {
                "n",
                "o",
            },
            function()
                require("flash").treesitter()
            end,
            desc = "Flash Treesitter",
        },
        {
            "r",
            mode = "o",
            function()
                require("flash").remote()
            end,
            desc = "Remote Flash",
        },
        {
            "R",
            mode = { "o", "x" },
            function()
                require("flash").treesitter_search()
            end,
            desc = "Treesitter Search",
        },
        -- No <C-s> map: Ctrl-S is terminal XOFF flow control.
    },
    config = function()
        require("flash").setup({
            labels = "asdfghjklqwertyuiopzxcvbnm",
            search = {
                multi_window = true,
                forward = true,
                wrap = true,
            },
            jump = {
                jumplist = true,
                pos = "start",
                history = false,
                register = false,
                nohlsearch = false,
                autojump = false,
            },
            label = {
                uppercase = true,
                rainbow = {
                    enabled = false,
                    shade = 5,
                },
            },
            modes = {
                search = {
                    enabled = true,
                },
                char = {
                    enabled = true,
                    jump_labels = true,
                },
            },
        })
    end,
}
