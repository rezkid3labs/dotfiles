return {
  "nvim-telescope/telescope.nvim",
  opts = function(_, opts)
    -- Ensure pickers and find_files exist
    if not opts.pickers then
      opts.pickers = {}
    end
    if not opts.pickers.find_files then
      opts.pickers.find_files = {}
    end

    -- Override the find_command for find_files
    opts.pickers.find_files.find_command = function()
      if 1 == vim.fn.executable("rg") then
        return {
          "rg",
          "--files",
          "--hidden",
          "--no-ignore",
          "--color",
          "never",
          "-g",
          "!.git",
          "-g",
          "!node_modules",
          "-g",
          "!dist",
        }
      elseif 1 == vim.fn.executable("fd") then
        return {
          "fd",
          "--type",
          "f",
          "--hidden",
          "--no-ignore",
          "--color",
          "never",
          "-E",
          ".git",
          "-E",
          "node_modules",
          "-E",
          "dist",
        }
      elseif 1 == vim.fn.executable("fdfind") then
        return {
          "fdfind",
          "--type",
          "f",
          "--hidden",
          "--no-ignore",
          "--color",
          "never",
          "-E",
          ".git",
          "-E",
          "node_modules",
          "-E",
          "dist",
        }
        -- Add other conditions as needed
      elseif 1 == vim.fn.executable("find") and vim.fn.has("win32") == 0 then
        return { "find", ".", "-type", "f" }
      elseif 1 == vim.fn.executable("where") then
        return { "where", "/r", ".", "*" }
      end
    end

    return opts
  end,
}
