return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lua",
        "L3MON4D3/LuaSnip",
        "rafamadriz/friendly-snippets",
        "folke/lazydev.nvim",
    },
    config = function()
        require("luasnip.loaders.from_vscode").lazy_load()

        require("mason").setup({
            ui = {
                border = "double",
            },
        })
        require("mason-lspconfig").setup({
            automatic_enable = false,
            ensure_installed = {
                "pyright",
                "ruff",
                "clangd",
                "gopls",
                "rust_analyzer",
                "vtsls",
                "eslint",
                "html",
                "cssls",
                "tailwindcss",
                "intelephense",
                "lua_ls",
                "jsonls",
                "yamlls",
                "bashls",
                "taplo",
                "dockerls",
                "lemminx",
                "csharp_ls",
            },
        })
        require("mason-tool-installer").setup({
            ensure_installed = {
                "sqlfluff",
                "stylua",
                "ktlint",
            },
        })

        local cmp = require("cmp")
        local luasnip = require("luasnip")

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<CR>"] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                }),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),
            sources = {
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "buffer" },
                { name = "path" },
                { name = "nvim_lua" },
            },
        })

        vim.lsp.config("*", {
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
        })

        require("lazydev").setup()

        vim.lsp.config("lua_ls", {
            settings = {
                Lua = {
                    runtime = { version = "LuaJIT" },
                    diagnostics = { globals = { "vim", "require" } },
                    workspace = { checkThirdParty = false },
                    telemetry = { enable = false },
                },
            },
        })

        vim.lsp.config("pyright", {
            settings = {
                python = {
                    analysis = {
                        typeCheckingMode = "basic",
                        autoSearchPaths = true,
                        diagnosticMode = "workspace",
                    },
                },
            },
        })

        vim.lsp.config("ruff", {
            init_options = {
                settings = { args = {} },
            },
        })

        vim.lsp.config("clangd", {
            cmd = {
                "clangd",
                "--background-index",
                "--clang-tidy",
                "--header-insertion=iwyu",
                "--completion-style=detailed",
                "--function-arg-placeholders=true",
            },
        })

        vim.lsp.config("gopls", {
            settings = {
                gopls = {
                    analyses = { unusedparams = true },
                    staticcheck = true,
                    gofumpt = true,
                },
            },
        })

        vim.lsp.config("rust_analyzer", {
            settings = {
                ["rust-analyzer"] = {
                    check = { command = "clippy" },
                },
            },
        })

        vim.lsp.config("vtsls", {
            settings = {
                typescript = {
                    preferences = { importModuleSpecifierPreference = "relative" },
                },
                javascript = {
                    preferences = { importModuleSpecifierPreference = "relative" },
                },
            },
        })

        vim.lsp.config("eslint", {
            settings = {
                format = { enable = false },
            },
        })

        vim.lsp.config("html", {
            filetypes = { "html", "blade" },
        })

        vim.lsp.config("tailwindcss", {
            filetypes = {
                "html",
                "blade",
                "php",
                "javascript",
                "typescript",
                "javascriptreact",
                "typescriptreact",
            },
        })

        vim.lsp.config("intelephense", {
            filetypes = { "php", "blade" },
            settings = {
                intelephense = {
                    files = { maxSize = 5000000 },
                    environment = { phpVersion = "8.3" },
                    diagnostics = { enabled = true },
                    stubs = {
                        -- Core & stdlib
                        "core",
                        "standard",
                        "meta",
                        "superglobals",
                        -- Strings & encoding
                        "mbstring",
                        "iconv",
                        -- Date / time
                        "date",
                        -- Math
                        "bcmath",
                        "gmp",
                        -- Data formats
                        "json",
                        "xml",
                        "xmlreader",
                        "xmlwriter",
                        "simplexml",
                        "dom",
                        -- Regex & data structures
                        "pcre",
                        "spl",
                        -- Filesystem
                        "fileinfo",
                        "zip",
                        "zlib",
                        -- Networking & security
                        "curl",
                        "openssl",
                        "sockets",
                        "sodium",
                        "random",
                        -- Database (everything you'll hit with Laravel)
                        "pdo",
                        "pdo_mysql",
                        "pdo_sqlite",
                        "pdo_pgsql",
                        "mysqli",
                        "sqlite3",
                        -- Sessions, auth & filtering
                        "session",
                        "hash",
                        "filter",
                        -- Image
                        "gd",
                        -- CLI & process
                        "posix",
                        "pcntl",
                        "readline",
                        -- Reflection (handy for exploring Laravel internals)
                        "reflection",
                        -- Misc
                        "tokenizer",
                        "ctype",
                        "intl",
                        -- Frameworks
                        "laravel",
                        "wordpress",
                    },
                },
            },
        })

        vim.lsp.enable({
            "lua_ls",
            "pyright",
            "ruff",
            "clangd",
            "gopls",
            "rust_analyzer",
            "vtsls",
            "eslint",
            "html",
            "cssls",
            "tailwindcss",
            "intelephense",
            "jsonls",
            "yamlls",
            "bashls",
            "taplo",
            "dockerls",
            "lemminx",
            "csharp_ls",
        })

        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if not client then
                    return
                end

                local function map(mode, lhs, rhs, desc)
                    vim.keymap.set(mode, lhs, rhs, { buffer = args.buf, silent = true, desc = desc })
                end

                map("n", "gD", vim.lsp.buf.declaration, "LSP: Go to declaration")
                map("n", "gd", vim.lsp.buf.definition, "LSP: Go to definition")
                map("n", "K", vim.lsp.buf.hover, "LSP: Hover documentation")
                map("n", "gi", vim.lsp.buf.implementation, "LSP: Go to implementation")
                map("n", "<C-S-k>", vim.lsp.buf.signature_help, "LSP: Signature help")
                map("n", "<leader>D", vim.lsp.buf.type_definition, "LSP: Type definition")
                map("n", "gr", vim.lsp.buf.references, "LSP: References")

                map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, "LSP: Add workspace folder")
                map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "LSP: Remove workspace folder")
                map("n", "<leader>wl", function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, "LSP: List workspace folders")

                map("n", "<leader>rn", vim.lsp.buf.rename, "LSP: Rename symbol")
                map("n", "<leader>ca", vim.lsp.buf.code_action, "LSP: Code action")

                map("n", "[d", function()
                    vim.diagnostic.jump({ count = -1 })
                end, "LSP: Previous diagnostics")
                map("n", "]d", function()
                    vim.diagnostic.jump({ count = 1 })
                end, "LSP: Next diagnostics")
                map("n", "gl", vim.diagnostic.open_float, "LSP: Open diagnostic float")
            end,
        })

        vim.diagnostic.config({
            virtual_text = false,
            virtual_lines = true,
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = " ",
                    [vim.diagnostic.severity.WARN] = " ",
                    [vim.diagnostic.severity.HINT] = " ",
                    [vim.diagnostic.severity.INFO] = " ",
                },
            },
            underline = true,
            update_in_insert = false,
            severity_sort = true,
        })

        local sqlfluff_bin = vim.fn.stdpath("data") .. "/mason/bin/sqlfluff"

        local function sql_dialect(bufnr)
            if vim.b[bufnr].sqlfluff_dialect then
                return vim.b[bufnr].sqlfluff_dialect
            end

            local dir = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":p:h")
            local conf = vim.fn.findfile(".sqlfluff", dir .. ";")
            if conf ~= "" then
                for line in io.lines(conf) do
                    local d = line:match("^%s*dialect%s*=%s*(%S+)")
                    if d then
                        return d
                    end
                end
            end

            local text = table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false), "\n")
            if
                text:match("ENGINE%s*=")
                or text:match("ENUM%s*%(")
                or text:match("AUTO_INCREMENT")
                or text:match("BINARY%s*%(")
            then
                return "mysql"
            end
            if
                text:match("AUTOINCREMENT")
                or text:match("PRAGMA")
                or text:match("WITHOUT%s+ROWID")
                or text:match("INTEGER%s+PRIMARY%s+KEY")
            then
                return "sqlite"
            end
            return "sqlite"
        end

        if vim.fn.executable(sqlfluff_bin) == 1 then
            local ns = vim.api.nvim_create_namespace("sqlfluff")
            local timers = {}

            local function lint(bufnr)
                timers[bufnr] = nil
                if not vim.api.nvim_buf_is_valid(bufnr) or not vim.api.nvim_buf_is_loaded(bufnr) then
                    return
                end

                local args = { "lint", "--format", "json", "--dialect", sql_dialect(bufnr), "-" }
                local stdin = vim.uv.new_pipe(false)
                local stdout = vim.uv.new_pipe(false)
                local stderr = vim.uv.new_pipe(false)
                local out, err, done = "", "", false

                local function finish()
                    if done then
                        return
                    end
                    done = true
                    -- uv callbacks run in a fast event context; defer API calls
                    vim.schedule(function()
                        if not vim.api.nvim_buf_is_valid(bufnr) then
                            return
                        end
                        local diags = {}
                        local ok, data = pcall(vim.json.decode, out)
                        if ok and data and data[1] then
                            for _, v in ipairs(data[1].violations or {}) do
                                if v.code == "PRS" then
                                    table.insert(diags, {
                                        lnum = v.start_line_no - 1,
                                        col = v.start_line_pos - 1,
                                        end_lnum = v.end_line_no - 1,
                                        end_col = v.end_line_pos - 1,
                                        severity = vim.diagnostic.severity.ERROR,
                                        message = v.description,
                                        source = "sqlfluff",
                                    })
                                end
                            end
                        end
                        vim.diagnostic.set(ns, bufnr, diags, {})
                    end)
                end

                local pid = vim.uv.spawn(sqlfluff_bin, {
                    args = args,
                    stdio = { stdin, stdout, stderr },
                }, function()
                    stdout:close()
                    stderr:close()
                    finish()
                end)

                if not pid then
                    stdin:close()
                    stdout:close()
                    stderr:close()
                    finish()
                    return
                end

                stdout:read_start(function(_, data)
                    if data then
                        out = out .. data
                    end
                end)
                stderr:read_start(function(_, data)
                    if data then
                        err = err .. data
                    end
                end)
                stdin:write(table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false), "\n"), function()
                    stdin:close()
                end)
            end

            local function schedule(bufnr)
                if timers[bufnr] then
                    timers[bufnr]:close()
                end
                timers[bufnr] = vim.defer_fn(function()
                    lint(bufnr)
                end, 250)
            end

            vim.api.nvim_create_autocmd("FileType", {
                pattern = "sql",
                callback = function(args)
                    schedule(args.buf)
                end,
            })

            vim.api.nvim_create_autocmd("BufWritePost", {
                pattern = "*.sql",
                callback = function(args)
                    schedule(args.buf)
                end,
            })
        end
    end,
}
