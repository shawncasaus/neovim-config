local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)
vim.g.vscode = vim.g.vscode or vim.env.VSCODE_NVIM == "1" or vim.g.vscode ~= nil
local IN_VSCODE = vim.g.vscode ~= nil

require("vim-options")
require("lazy").setup("plugins")
