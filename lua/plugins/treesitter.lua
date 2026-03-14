return {
    "nvim-treesitter/nvim-treesitter",
    enabled = not vim.g.vscode,
    build = ":TSUpdate",
    opts = {
        -- make sure these are present (add/remove to taste)
        ensure_installed = {
            "rust", "lua", "vim", "vimdoc", "bash",
            "javascript", "typescript", "json", "jsonc",
            "markdown", "markdown_inline", "yaml", "html", "css",
            -- Next.js / React
            "tsx", "scss", "prisma", "graphql",
        },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
        -- optional QoL:
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "gnn",
                node_incremental = "grn",
                scope_incremental = "grc",
                node_decremental = "grm",
            },
        },
    },
    config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
    end,
}
