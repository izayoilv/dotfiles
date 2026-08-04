return {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim",
    },
    cmd = "Neogit",
    keys = {
        { "<leader>gg", "<cmd>Neogit<cr>", desc = "Neogit" },
        { "<leader>gC", "<cmd>Neogit commit<cr>", desc = "Neogit Commit" },
    },
    config = function()
        require("neogit").setup({
            integrations = {
                diffview = true,
                snacks = true,
            },
            commit_select_view = {
                kind = "tab",
            },
            commit_popup = {
                kind = "split",
            },
            signs = {
                hunk = { "", "" },
                item = { "▸", "▾" },
                section = { "▸", "▾" },
            },
            sections = {
                untracked = { folded = false, hidden = false },
                unstaged = { folded = false, hidden = false },
                staged = { folded = false, hidden = false },
                stashes = { folded = true, hidden = false },
                unpulled = { folded = true, hidden = false },
                unmerged = { folded = false, hidden = false },
                recent = { folded = true, hidden = false },
            },
        })
    end,
}
