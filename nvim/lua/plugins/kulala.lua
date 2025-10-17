return {
  {
    "mistweaverco/kulala.nvim",
    keys = function(_, keys)
      -- extend keymap bawaan Kulala
      vim.list_extend(keys, {
        {
          "<A-r>",
          function()
            require("kulala").run()
          end,
          desc = "Run Kulala request (Alt+R)",
        },
      })
      return keys
    end,
  },
}
