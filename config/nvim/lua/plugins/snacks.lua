local function toggle_term()
    local arg = vim.fn.argv()[1]
    local cwd
    if arg and vim.fn.isdirectory(arg) == 1 then
        cwd = vim.fn.fnamemodify(arg, ":p")
    end
    Snacks.terminal.toggle(nil, { cwd = cwd })
end

return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        bigfile = { enabled = true },
        explorer = {
            enabled = true,
            replace_netrw = true,
        },
        indent = { enabled = true },
        image = { enabled = true },
        input = { enabled = true },
        notifier = { enabled = true },
        picker = {
            enabled = true,
            sources = {
                explorer = {
                    hidden = true,
                    layout = { layout = { position = "left", width = 35 } },
                },
            },
        },
        quickfile = { enabled = true },
        scope = { enabled = true },
        scroll = { enabled = true },
        statuscolumn = { enabled = true },
        terminal = {
            enabled = true,
            win = {
                position = "float",
                border = "double",
            },
        },
        words = { enabled = true },
    },
    keys = {
        {
            "<leader>ff",
            function()
                Snacks.picker.files()
            end,
            desc = "Find files",
        },
        {
            "<leader>fg",
            function()
                Snacks.picker.grep()
            end,
            desc = "Live grep",
        },
        {
            "<leader>fb",
            function()
                Snacks.picker.buffers()
            end,
            desc = "Buffers",
        },
        {
            "<leader>fh",
            function()
                Snacks.picker.help()
            end,
            desc = "Help tags",
        },
        {
            "<leader>cd",
            function()
                local explorer = Snacks.picker.get({ source = "explorer" })[1]
                if explorer then
                    explorer:close()
                else
                    Snacks.explorer.open()
                end
            end,
            desc = "Explorer: toggle sidebar",
        },
        {
            "<leader>cf",
            function()
                Snacks.explorer.reveal()
            end,
            desc = "Explorer: reveal current file",
        },
        { "<leader>/", toggle_term, desc = "Toggle terminal" },
    },
    config = function(_, opts)
        require("snacks").setup(opts)

        vim.ui.input = Snacks.input.input
        vim.ui.select = Snacks.picker.select

        -- Single <esc> exits to terminal-normal mode (overrides snacks'
        -- default double-esc; applied after its style keys, so it wins).
        vim.api.nvim_create_autocmd("TermOpen", {
            pattern = "term://*",
            callback = function()
                vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], { buffer = 0, desc = "Escape to normal" })
                vim.keymap.set("t", "<leader>/", toggle_term, { buffer = 0, desc = "Toggle terminal" })
            end,
        })
    end,
}
