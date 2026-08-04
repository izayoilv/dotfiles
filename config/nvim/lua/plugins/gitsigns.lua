return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("gitsigns").setup({
            signs = {
                add = { text = "│" },
                change = { text = "│" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
                untracked = { text = "┆" },
            },
            signcolumn = true,
            numhl = false,
            linehl = false,
            word_diff = false,
            watch_gitdir = {
                interval = 1000,
                follow_files = true,
            },
            attach_to_untracked = true,
            current_line_blame = false,
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = "eol",
                delay = 500,
                ignore_whitespace = false,
            },
            current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
            sign_priority = 6,
            update_debounce = 100,
            preview_config = {
                border = "double",
                style = "minimal",
                relative = "cursor",
                row = 0,
                col = 1,
            },
            on_attach = function(bufnr)
                local gs = require("gitsigns")

                local function map(mode, lhs, rhs, desc)
                    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
                end

                map("n", "]h", function()
                    if vim.wo.diff then
                        vim.cmd.normal({ "]c", bang = true })
                    else
                        gs.nav_hunk("next")
                    end
                end, "Git: next hunk")

                map("n", "[h", function()
                    if vim.wo.diff then
                        vim.cmd.normal({ "[c", bang = true })
                    else
                        gs.nav_hunk("prev")
                    end
                end, "Git: prev hunk")

                map("n", "<leader>gs", gs.stage_hunk, "Git: stage hunk")
                map("n", "<leader>gS", gs.stage_buffer, "Git: stage buffer")
                map("n", "<leader>gu", gs.undo_stage_hunk, "Git: undo stage hunk")

                map("v", "<leader>gs", function()
                    gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
                end, "Git: stage selected lines")

                map("n", "<leader>gr", gs.reset_hunk, "Git: reset hunk")
                map("n", "<leader>gR", gs.reset_buffer, "Git: reset buffer")

                map("v", "<leader>gr", function()
                    gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
                end, "Git: reset selected lines")

                map("n", "<leader>gp", gs.preview_hunk, "Git: preview hunk")
                map("n", "<leader>gb", gs.toggle_current_line_blame, "Git: toggle line blame")
                map("n", "<leader>gB", function()
                    gs.blame_line({ full = true })
                end, "Git: blame line (full)")

                map("n", "<leader>gd", gs.diffthis, "Git: diff this")
                map("n", "<leader>gD", function()
                    gs.diffthis("~")
                end, "Git: diff this ~")

                map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Git: select hunk")
            end,
        })
    end,
}
