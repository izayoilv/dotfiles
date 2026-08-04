local M = {}

local function worktree()
    return require("git-worktree")
end

local function worktree_items()
    local output = vim.fn.systemlist({ "git", "worktree", "list" })
    local items = {}
    for _, line in ipairs(output) do
        local fields = vim.split(string.gsub(line, "%s+", " "), " ")
        local path, branch = fields[1], fields[3]
        if branch then
            branch = branch:gsub("[%[%]]", "")
        end
        table.insert(items, { path = path, branch = branch, text = path })
    end
    return items
end

function M.switch()
    Snacks.picker.pick({
        source = "git_worktree",
        title = "Git Worktrees",
        items = worktree_items(),
        format = function(item)
            return { { item.path, "Directory" }, { "  " .. (item.branch or ""), "Comment" } }
        end,
        confirm = function(_, item)
            worktree().switch_worktree(item.path)
        end,
        actions = {
            delete = function(_, item)
                vim.ui.input({ prompt = ("Delete worktree '%s'? (y/N): "):format(item.path) }, function(answer)
                    if answer and answer:lower() == "y" then
                        worktree().delete_worktree(item.path, true)
                    end
                end)
            end,
        },
        win = {
            input = {
                keys = {
                    ["d"] = { "delete", desc = "Delete worktree" },
                },
            },
        },
    })
end

function M.create()
    local default_branch = vim.fn.systemlist("git branch --show-current")[1] or ""
    vim.ui.input({ prompt = "Worktree path: " }, function(path)
        if not path or path == "" then
            return
        end
        vim.ui.input({ prompt = "Branch name: ", default = default_branch }, function(branch)
            if not branch or branch == "" then
                return
            end
            vim.ui.input({ prompt = "Upstream (optional): " }, function(upstream)
                worktree().create_worktree(path, branch, upstream ~= "" and upstream or nil)
            end)
        end)
    end)
end

return M
