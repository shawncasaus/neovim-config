return {
    "github/copilot.vim",
    enabled = not vim.g.vscode,
    config = function()
        -- Disable default Tab mapping (conflicts with nvim-cmp)
        vim.g.copilot_no_tab_map = true

        -- Set up custom keybindings for Copilot
        vim.keymap.set("i", "<C-j>", 'copilot#Accept("<CR>")', {
            expr = true,
            replace_keycodes = false,
            desc = "Copilot: Accept suggestion",
        })
        vim.keymap.set("i", "<M-]>", "<Plug>(copilot-next)", { desc = "Copilot: Next suggestion" })
        vim.keymap.set("i", "<M-[>", "<Plug>(copilot-previous)", { desc = "Copilot: Previous suggestion" })
        vim.keymap.set("i", "<C-\\>", "<Plug>(copilot-dismiss)", { desc = "Copilot: Dismiss suggestion" })

        -- Enable Copilot for all filetypes (optional - customize as needed)
        vim.g.copilot_filetypes = {
            ["*"] = true,
            ["markdown"] = true,
            ["yaml"] = true,
        }
    end,
}
