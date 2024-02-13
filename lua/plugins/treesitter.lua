return {
    'nvim-treesitter/nvim-treesitter', 
    build=':TSUpdate',
    config = function()
        local config = require("nvim-treesitter.configs")
        config.setup({
            ensure_installed = {"lua", "javascript", "typescript", "html", "tsx", "java", "css", "git_config", "gitignore", "json"},
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },
        })
    end
}

