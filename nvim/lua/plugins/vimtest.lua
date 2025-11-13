-- LazyVim Test Runner Configuration
-- Save as: ~/.config/nvim/lua/plugins/test-runner.lua

return {
  "vim-test/vim-test",
  dependencies = {
    "preservim/vimux", -- optional: for tmux integration
  },
  keys = {
    { "<leader>tt", "<cmd>TestNearest<cr>", desc = "Test Nearest" },
    { "<leader>tf", "<cmd>TestFile<cr>", desc = "Test File" },
    { "<leader>ts", "<cmd>TestSuite<cr>", desc = "Test Suite" },
    { "<leader>tl", "<cmd>TestLast<cr>", desc = "Test Last" },
    { "<leader>tv", "<cmd>TestVisit<cr>", desc = "Test Visit" },
  },
  config = function()
    -- Use neovim terminal
    vim.g["test#strategy"] = "vimux"

    -- Or use tmux (if you prefer)
    -- vim.g["test#strategy"] = "vimux"

    -- Or use toggleterm (if installed)
    -- vim.g["test#strategy"] = "toggleterm"

    -- Yarn configuration
    vim.g["test#javascript#runner"] = "jest" -- or "vitest"
    vim.g["test#javascript#jest#executable"] = "yarn test"
  end,
}
