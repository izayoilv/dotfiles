return {
    "mrjones2014/smart-splits.nvim",
    keys = {
        { "<A-h>", "<cmd>SmartResizeLeft<cr>", desc = "Resize left" },
        { "<A-j>", "<cmd>SmartResizeDown<cr>", desc = "Resize down" },
        { "<A-k>", "<cmd>SmartResizeUp<cr>", desc = "Resize up" },
        { "<A-l>", "<cmd>SmartResizeRight<cr>", desc = "Resize right" },

        {
            "<C-h>",
            function()
                require("smart-splits").move_cursor_left()
            end,
            desc = "Go to left window",
        },
        {
            "<C-j>",
            function()
                require("smart-splits").move_cursor_down()
            end,
            desc = "Go to below window",
        },
        {
            "<C-k>",
            function()
                require("smart-splits").move_cursor_up()
            end,
            desc = "Go to above window",
        },
        {
            "<C-l>",
            function()
                require("smart-splits").move_cursor_right()
            end,
            desc = "Go to right window",
        },
    },
    opts = {
        ignored_filetypes = { "nofile", "prompt", "qf" },
        default_amount = 3,
    },
}
