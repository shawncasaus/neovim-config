-- lua/plugins/formatting.lua
return {
    {
        "stevearc/conform.nvim",
        enabled = not vim.g.vscode,
        opts = {
            formatters_by_ft = {
                -- Rust: use rustfmt (via conform’s external runner). LSP fallback covers you too.
                rust = { "rustfmt" },

                -- Web stuff: prefer prettierd, fall back to prettier
                javascript = { "prettierd", "prettier" },
                typescript = { "prettierd", "prettier" },
                javascriptreact = { "prettierd", "prettier" },
                typescriptreact = { "prettierd", "prettier" },
                json = { "prettierd", "prettier" },
                jsonc = { "prettierd", "prettier" },
                markdown = { "prettierd", "prettier" },
                yaml = { "prettierd", "prettier" },
                html = { "prettierd", "prettier" },
                css = { "prettierd", "prettier" },
                scss = { "prettierd", "prettier" },
            },
            format_on_save = function(bufnr)
                if vim.b[bufnr].disable_autoformat then return end
                return { lsp_fallback = true, timeout_ms = 2000 }
            end,
        },
        config = function(_, opts)
            require("conform").setup(opts)
            -- manual format
            vim.keymap.set({ "n", "v" }, "<leader>f", function()
                require("conform").format({ lsp_fallback = true, timeout_ms = 2000 })
            end, { desc = "Format buffer" })
        end,
    },
    -- Optional: ask Mason to install formatters (Conform can run external bins)
    {
        "williamboman/mason.nvim",
        opts = function(_, o)
            o.ensure_installed = o.ensure_installed or {}
            vim.list_extend(o.ensure_installed, { "rust-analyzer", "prettierd" })
        end,
    },
}
