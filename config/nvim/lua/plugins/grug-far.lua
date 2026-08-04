return {
    "MagicDuck/grug-far.nvim",
    cmd = "GrugFar",
    keys = {
        {
            "<leader>sr",
            function()
                require("grug-far").open()
            end,
            desc = "Search and Replace",
        },
        {
            "<leader>sw",
            function()
                require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })
            end,
            desc = "Search word under cursor",
        },
        {
            "<leader>sf",
            function()
                require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } })
            end,
            desc = "Search in current file",
        },
        {
            "<leader>sR",
            mode = { "n", "v" },
            function()
                local grug = require("grug-far")
                local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
                grug.open({
                    transient = true,
                    prefills = {
                        filesFilter = ext and ext ~= "" and "*." .. ext or nil,
                    },
                })
            end,
            desc = "Search and Replace (filetype)",
        },
    },
    config = function()
        require("grug-far").setup({
            keymaps = {
                replace = { n = "<leader>r" },
                qflist = { n = "<leader>q" },
                syncLocations = { n = "<leader>s" },
                syncLine = { n = "<leader>l" },
                close = { n = "<leader>c" },
                historyOpen = { n = "<leader>h" },
                historyAdd = { n = "<leader>a" },
                refresh = { n = "<leader>f" },
                openLocation = { n = "<leader>o" },
                gotoLocation = { n = "<enter>" },
                pickHistoryEntry = { n = "<enter>" },
                abort = { n = "<leader>x" },
                help = { n = "g?" },
            },
            icons = {
                enabled = true,
            },
            engine = "ripgrep",
        })
    end,
}
