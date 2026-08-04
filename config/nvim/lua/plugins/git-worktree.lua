-- NOTE: required lazily at callback time so vim.g.git_worktree is already set.
return {
    "polarmutex/git-worktree.nvim",
    version = "^2",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
        {
            "<leader>gw",
            function()
                require("config.git_worktree_picker").switch()
            end,
            desc = "Git Worktrees",
        },
        {
            "<leader>gW",
            function()
                require("config.git_worktree_picker").create()
            end,
            desc = "Create Worktree",
        },
    },
    config = function()
        -- This fork has no setup(); configure via vim.g.git_worktree,
        -- set before the plugin's config module is required.
        vim.g.git_worktree = {
            change_directory_command = "cd",
            update_on_change_command = "e .",
            clearjumps_on_change = true,
            autopush = false,
        }

        local Hooks = require("git-worktree.hooks")
        local config = require("git-worktree.config")
        Hooks.register(Hooks.type.SWITCH, function(path, prev_path)
            vim.notify("Moved from " .. prev_path .. " to " .. path)
            Hooks.builtins.update_current_buffer_on_switch(path, prev_path)
        end)
        Hooks.register(Hooks.type.DELETE, function()
            vim.cmd(config.update_on_change_command)
        end)
    end,
}
