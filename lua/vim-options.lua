vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set relativenumber")
vim.cmd("set number")
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>nh", ":nohl", {})
vim.keymap.set("n", "<leader>nN", ":set nonumber", {})
vim.keymap.set("n", "<leader>N", ":set number", {})
vim.keymap.set("n", "<leader>S", ":w!", {})
vim.keymap.set("n", "<leader>Sa", ":wa!", {})
vim.keymap.set("n", "<leader>vs", ":vsplit", {})
vim.keymap.set("n", "<leader>tn", ":tab new", {})
vim.keymap.set("n", "<leader>e", function()
    vim.diagnostic.open_float(nil, { focus = false })
end, { desc = "Show diagnostic under cursor" })
vim.keymap.set("n", "<C-i>", function()
    vim.diagnostic.open_float(nil, { focus = false })
end, { desc = "Show diagnostic under cursor" })

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })

-- Window resizing
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })

-- === Search / Grep hotkeys ===
local map = vim.keymap.set
local IN_VSCODE = vim.g.vscode ~= nil

if IN_VSCODE then
    -- Files: Quick Open (same as Ctrl+P)
    map("n", "<leader>ff", function()
        vim.fn.VSCodeNotify("workbench.action.quickOpen")
    end, { desc = "VSCode: Find files" })

    -- Content: Search in files (same as Ctrl+Shift+F)
    map("n", "<leader>fg", function()
        vim.fn.VSCodeNotify("workbench.action.findInFiles")
    end, { desc = "VSCode: Grep in workspace" })

    -- Grep current word across workspace
    map("n", "<leader>fw", function()
        local word = vim.fn.expand("<cword>")
        -- VS Code command accepts args; vscode-neovim forwards them.
        vim.fn.VSCodeNotify("workbench.action.findInFiles", {
            query = word,
            triggerSearch = true,
            isRegex = false,
            matchWholeWord = true,
        })
    end, { desc = "VSCode: Grep word under cursor" })
else
    -- Terminal Neovim
    local has_telescope, telescope = pcall(require, "telescope.builtin")

    if has_telescope then
        map("n", "<leader>ff", telescope.find_files, { desc = "Find files" })
        map("n", "<leader>fg", telescope.live_grep, { desc = "Live grep" })
        map("n", "<leader>fw", telescope.grep_string, { desc = "Grep word under cursor" })
    else
        -- Fallback: ripgrep -> quickfix
        map("n", "<leader>ff", ":find ", { desc = ":find file by path" })
        map("n", "<leader>fg", function()
            local q = vim.fn.input("RG > ")
            if q ~= "" then
                vim.cmd("silent grep! " .. vim.fn.shellescape(q))
                vim.cmd("copen")
            end
        end, { desc = "ripgrep into quickfix" })
        map("n", "<leader>fw", function()
            local w = vim.fn.expand("<cword>")
            vim.cmd("silent grep! -w " .. vim.fn.shellescape(w))
            vim.cmd("copen")
        end, { desc = "ripgrep word into quickfix" })
    end
end
