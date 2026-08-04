return {
    "akinsho/git-conflict.nvim",
    event = "BufReadPre",
    config = function()
        require("git-conflict").setup({
            default_mappings = true,
            default_commands = true,
            disable_diagnostics = false,
            list_opener = "copen",
            highlights = {
                incoming = "DiffAdd",
                current = "DiffText",
            },
        })

        vim.keymap.set("n", "<leader>gco", "<cmd>GitConflictChooseOurs<cr>", { desc = "Choose Ours" })
        vim.keymap.set("n", "<leader>gct", "<cmd>GitConflictChooseTheirs<cr>", { desc = "Choose Theirs" })
        vim.keymap.set("n", "<leader>gcb", "<cmd>GitConflictChooseBoth<cr>", { desc = "Choose Both" })
        vim.keymap.set("n", "<leader>gc0", "<cmd>GitConflictChooseNone<cr>", { desc = "Choose None" })
        vim.keymap.set("n", "[x", "<cmd>GitConflictPrevConflict<cr>", { desc = "Previous Conflict" })
        vim.keymap.set("n", "]x", "<cmd>GitConflictNextConflict<cr>", { desc = "Next Conflict" })
        vim.keymap.set("n", "<leader>gcl", "<cmd>GitConflictListQf<cr>", { desc = "List Conflicts" })
    end,
}
