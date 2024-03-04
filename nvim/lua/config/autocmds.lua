-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Switch input method to english when enter normal mode from insert mode.
vim.api.nvim_create_autocmd("InsertLeave", {
  group = vim.api.nvim_create_augroup("switch_english_input", { clear = true }),
  pattern = "*",
  callback = function()
    if vim.fn.mode() == "n" then
      vim.cmd(":silent :!/usr/bin/fcitx5-remote -c")
    end
  end,
})
