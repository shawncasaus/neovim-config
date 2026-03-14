-- React / Next.js specific plugins
return {
    -- Auto close and rename HTML/JSX tags
    {
        "windwp/nvim-ts-autotag",
        event = "InsertEnter",
        opts = {
            opts = {
                enable_close = true,
                enable_rename = true,
                enable_close_on_slash = true,
            },
        },
    },
    -- Auto pairs for brackets, quotes, etc.
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {
            check_ts = true, -- Use treesitter to check for pairs
            ts_config = {
                lua = { "string" },
                javascript = { "template_string" },
                typescript = { "template_string" },
                javascriptreact = { "template_string" },
                typescriptreact = { "template_string" },
            },
        },
        config = function(_, opts)
            local npairs = require("nvim-autopairs")
            npairs.setup(opts)

            -- Integrate with nvim-cmp
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            local cmp = require("cmp")
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
    },
}
