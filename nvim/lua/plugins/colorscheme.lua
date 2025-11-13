return {
  -- {
  --   "catppuccin/nvim",
  --   opts = {
  --     flavour = "frappe", -- latte, frappe, macchiato, mocha
  --     background = { -- :h background
  --       light = "latte",
  --       dark = "frappe",
  --     },
  --     transparent_background = true, -- disables setting the background color.
  --     float = {
  --       transparent = true, -- enable transparent floating windows
  --       solid = false, -- use solid styling for floating windows, see |winborder|
  --     },
  --   },
  -- },
  --
  -- -- Configure LazyVim to load gruvbox
  -- {
  --   "LazyVim/LazyVim",
  --   opts = {
  --     colorscheme = "catppuccin-frappe",
  --   },
  -- },
  --
  {
    "sainnhe/everforest",
    lazy = false,
    priority = 1000,
    config = function()
      -- Optionally configure and load the colorscheme
      -- directly inside the plugin declaration.
      vim.g.everforest_enable_italic = true
      vim.cmd.colorscheme("everforest")
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "everforest",
    },
  },
}
