local function enable_transparency()
    local groups = {
        "Normal",
        "NormalNC",
        "NormalFloat",
        "SignColumn",
        "LineNr",
        "CursorLineNr",
        "EndOfBuffer",
        "FoldColumn",
    }
    for _, group in ipairs(groups) do
        -- `:highlight` keeps the group's fg etc.; nvim_set_hl() would
        -- replace the whole group
        vim.cmd(("highlight %s guibg=NONE"):format(group))
    end
end

return {
    {
        "rebelot/kanagawa.nvim",
        config = function()
            require("kanagawa").setup({
                variant = "wave", -- wave | dragon | lotus
            })
            vim.cmd.colorscheme("kanagawa-wave")
            if vim.g.transparent_background then
                enable_transparency()
            end
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            theme = "kanagawa",
        },
    },
}
