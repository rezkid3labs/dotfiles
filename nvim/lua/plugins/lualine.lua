return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      -- Insert "filetype" into the lualine_x section
      table.insert(opts.sections.lualine_x, "filetype")
    end,
  },
}
