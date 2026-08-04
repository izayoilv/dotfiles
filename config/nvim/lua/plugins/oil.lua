return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
        {
            "<leader>oe",
            function()
                require("oil").toggle_float()
            end,
            desc = "Oil: open file explorer",
        },
    },
    config = function()
        require("oil").setup({
            -- snacks.explorer (replace_netrw) owns the netrw replacement
            default_file_explorer = false,
            view_options = {
                show_hidden = true,
            },
            float = {
                padding = 2,
                max_width = 80,
                max_height = 30,
                border = "double",
                win_options = { winblend = 0 },
            },
            keymaps = {
                ["g?"] = "actions.show_help",
                ["<CR>"] = "actions.select",
                ["<C-v>"] = "actions.select_vsplit",
                ["<C-x>"] = "actions.select_split",
                ["<C-t>"] = "actions.select_tab",
                ["<C-p>"] = "actions.preview",
                ["<C-c>"] = "actions.close",
                ["<C-r>"] = "actions.refresh",
                ["-"] = "actions.parent",
                ["_"] = "actions.open_cwd",
                ["`"] = "actions.cd",
                ["~"] = "actions.tcd",
                ["gs"] = "actions.change_sort",
                ["gx"] = "actions.open_external",
                ["g."] = "actions.toggle_hidden",
            },
        })
    end,
}
