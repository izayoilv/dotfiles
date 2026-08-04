return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
        {
            "<leader>ha",
            function()
                require("harpoon"):list():add()
            end,
            desc = "Harpoon: add file",
        },
        {
            "<leader>hr",
            function()
                require("harpoon"):list():remove()
            end,
            desc = "Harpoon: remove file",
        },
        {
            "<leader>hc",
            function()
                require("harpoon"):list():clear()
            end,
            desc = "Harpoon: clear all",
        },
        {
            "<C-e>",
            function()
                require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
            end,
            desc = "Harpoon: quick menu",
        },
        {
            "<C-p>",
            function()
                require("harpoon"):list():prev()
            end,
            desc = "Harpoon: prev file",
        },
        {
            "<C-n>",
            function()
                require("harpoon"):list():next()
            end,
            desc = "Harpoon: next file",
        },
        {
            "<leader>1",
            function()
                require("harpoon"):list():select(1)
            end,
            desc = "Harpoon: file 1",
        },
        {
            "<leader>2",
            function()
                require("harpoon"):list():select(2)
            end,
            desc = "Harpoon: file 2",
        },
        {
            "<leader>3",
            function()
                require("harpoon"):list():select(3)
            end,
            desc = "Harpoon: file 3",
        },
        {
            "<leader>4",
            function()
                require("harpoon"):list():select(4)
            end,
            desc = "Harpoon: file 4",
        },
        {
            "<leader>fl",
            function()
                local harpoon = require("harpoon")
                local files = harpoon:list()
                if #files.items == 0 then
                    vim.notify("Harpoon list is empty", vim.log.levels.INFO)
                    return
                end

                local items = {}
                for i, item in ipairs(files.items) do
                    -- harpoon2 stores plain path strings (no .value field)
                    table.insert(items, { index = i, file = item.value or item })
                end

                Snacks.picker.pick({
                    source = "harpoon",
                    title = "Harpoon",
                    items = items,
                    format = "file",
                    confirm = function(_, item)
                        harpoon:list():select(item.index)
                    end,
                })
            end,
            desc = "Harpoon: list",
        },
    },
    config = function()
        require("harpoon"):setup({})
    end,
}
