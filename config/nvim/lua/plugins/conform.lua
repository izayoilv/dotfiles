return {
    "stevearc/conform.nvim",
    event = { "BufWritePre", "BufNewFile" },
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "ruff_format" },
                javascript = { "prettier" },
                typescript = { "prettier" },
                javascriptreact = { "prettier" },
                typescriptreact = { "prettier" },
                json = { "prettier" },
                jsonc = { "prettier" },
                html = { "prettier" },
                css = { "prettier" },
                markdown = { "prettier" },
                yaml = { "prettier" },
                php = { "prettier" },
                go = { "gofmt" },
                rust = { "rustfmt" },
                c = { "clang-format" },
                cpp = { "clang-format" },
            },
            format_on_save = {
                timeout_ms = 1000,
                lsp_format = "fallback",
            },
        })
    end,
}
