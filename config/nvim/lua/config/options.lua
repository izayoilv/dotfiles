vim.opt.number = true
vim.opt.cursorline = true
vim.opt.relativenumber = true
vim.g.transparent_background = true

local node_host = vim.fn.exepath("neovim-node-host")
if node_host == "" then
    local bun_host = vim.fn.glob("~/.bun/install/global/node_modules/neovim/bin/cli.js", false, true)
    node_host = bun_host[1] or ""
end
if node_host ~= "" then
    vim.g.node_host_prog = node_host
end

-- plenv-managed Perl provider (Neovim::Ext in ~/perl5)
vim.env.PERL5LIB = vim.fn.expand("~/perl5/lib/perl5") .. (vim.env.PERL5LIB and (":" .. vim.env.PERL5LIB) or "")
local perl_host = vim.fn.exepath("perl")
if perl_host ~= "" then
    vim.g.perl_host_prog = perl_host
end

-- proto-managed Ruby provider
local ruby_host = vim.fn.exepath("ruby")
if ruby_host ~= "" then
    vim.g.ruby_host_prog = ruby_host
end

-- uv-managed Python provider (isolated venv with pynvim)
local uv_python = vim.fn.expand("~/.local/share/nvim/python/bin/python")
if vim.fn.executable(uv_python) == 1 then
    vim.g.python3_host_prog = uv_python
end

local rocks = vim.fn.stdpath("data") .. "/lua-rocks/hererocks"
package.path = rocks .. "/share/lua/5.1/?.lua;" .. package.path
package.cpath = rocks .. "/lib/lua/5.1/?.so;" .. package.cpath

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false

local indent_2 = {
    "javascript",
    "typescript",
    "javascriptreact",
    "typescriptreact",
    "html",
    "css",
    "json",
    "yaml",
    "markdown",
}

vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
        if vim.tbl_contains(indent_2, vim.bo[args.buf].filetype) then
            vim.bo[args.buf].tabstop = 2
            vim.bo[args.buf].softtabstop = 2
            vim.bo[args.buf].shiftwidth = 2
        end
    end,
})

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.scrolloff = 8
vim.opt.completeopt = "menuone,noinsert,noselect"

vim.opt.swapfile = false
vim.opt.backup = false
vim.fn.mkdir(vim.fn.stdpath("data") .. "/undodir", "p")
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"
vim.opt.undofile = true

vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = "a"

vim.opt.signcolumn = "yes"
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.updatetime = 250

vim.opt.fillchars = { eob = " " }
