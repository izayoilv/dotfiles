return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        -- The rewrite has no ensure_installed/auto_install; setup() only
        -- accepts install_dir, everything else is silently ignored.
        require("nvim-treesitter").setup({})

        vim.api.nvim_create_autocmd("FileType", {
            callback = function(args)
                local lang = vim.bo[args.buf].filetype
                if lang == "" then
                    return
                end

                -- Not enabled automatically by the rewrite
                pcall(vim.treesitter.start)
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

                -- Only languages in nvim-treesitter's registry (skips
                -- snacks_terminal, help, etc.)
                if not require("nvim-treesitter.parsers")[lang] then
                    return
                end
                local installed = require("nvim-treesitter").get_installed("parsers")
                if vim.tbl_contains(installed, lang) then
                    return
                end
                vim.schedule(function()
                    vim.cmd("TSInstall " .. lang)
                end)
            end,
        })
    end,
}
