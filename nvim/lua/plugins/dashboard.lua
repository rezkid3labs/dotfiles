return {
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      -- Read quotes from file
      local quotes_file = vim.fn.stdpath("config") .. "/lua/plugins/coding-quotes.txt"
      local quotes = {}

      local file = io.open(quotes_file, "r")
      if file then
        for line in file:lines() do
          if line ~= "" then
            table.insert(quotes, line)
          end
        end
        file:close()
      end

      -- Fallback quotes if file doesn't exist
      if #quotes == 0 then
        quotes = {
          "Code is like humor. When you have to explain it, it's bad. - Cory House",
          "First, solve the problem. Then, write the code. - John Johnson",
          "Make it work, make it right, make it fast. - Kent Beck",
        }
      end

      -- Get a random quote
      math.randomseed(os.time())
      local random_quote = quotes[math.random(#quotes)]

      local logo = [[
██████╗ ███████╗███╗   ██╗    ██████╗ ███████╗██╗   ██╗
██╔══██╗██╔════╝████╗  ██║    ██╔══██╗██╔════╝██║   ██║
██████╔╝█████╗  ██╔██╗ ██║    ██║  ██║█████╗  ██║   ██║
██╔══██╗██╔══╝  ██║╚██╗██║    ██║  ██║██╔══╝  ╚██╗ ██╔╝
██║  ██║███████╗██║ ╚████║    ██████╔╝███████╗ ╚████╔╝ 
╚═╝  ╚═╝╚══════╝╚═╝  ╚═══╝    ╚═════╝ ╚══════╝  ╚═══╝
                           ]]

      opts.dashboard = {
        enabled = true,
        preset = {
          header = logo .. "\n\n" .. random_quote,
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            {
              icon = " ",
              key = "c",
              desc = "Config",
              action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
            },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
      }
    end,
  },
}
