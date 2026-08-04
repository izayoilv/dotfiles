return {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
        { "<leader>gv", "<cmd>DiffviewOpen<cr>", desc = "Git Diff View" },
        { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "Git File History" },
        { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Git Branch History" },
        -- No <leader>gc map: it would shadow the git-conflict <leader>gc* prefix.
    },
    config = function()
        require("diffview").setup({
            enhanced_diff_hl = true,
            file_panel = {
                listing_style = "tree",
                tree_options = {
                    flatten_dirs = true,
                    folder_statuses = "only_folded",
                },
                win_config = {
                    position = "left",
                    width = 35,
                },
            },
            file_history_panel = {
                win_config = {
                    position = "bottom",
                    height = 16,
                },
            },
            keymaps = {
                view = {
                    { "n", "<leader>gs", "<cmd>DiffviewToggleStaged<cr>", { desc = "Toggle Staged" } },
                },
                file_panel = {
                    {
                        "n",
                        "s",
                        "<cmd>lua require('diffview.actions').toggle_stage_entry()<cr>",
                        { desc = "Stage/Unstage" },
                    },
                    { "n", "S", "<cmd>lua require('diffview.actions').stage_all()<cr>", { desc = "Stage All" } },
                    { "n", "U", "<cmd>lua require('diffview.actions').unstage_all()<cr>", { desc = "Unstage All" } },
                },
            },
        })
    end,
}
