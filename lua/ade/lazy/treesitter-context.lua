-- return {
--   "nvim-treesitter/nvim-treesitter-context",
--   event = "VeryLazy",
--   dependencies = { "nvim-treesitter/nvim-treesitter" },
--   config = function()
--     require("treesitter-context").setup({
--       enable = true, -- Enable this plugin
--       max_lines = 3, -- Max number of lines to show
--       trim_scope = "outer", -- Remove outer context when max_lines is hit
--       mode = "cursor", -- Use cursor position to determine context
--       zindex = 20, -- Floating window priority
--     })
--   end,
-- }
-- NOTE: USE: for sticky fun context
return {
  "nvim-treesitter/nvim-treesitter-context",
  name = "treesitter-context",
  opts = {
    enable = true,            -- Enable the plugin
    throttle = true,          -- Throttle for performance
    max_lines = 1,            -- Show up to 1 line of context by default
    multiline_threshold = 20, -- Only show context if function has 20+ lines
    trim_scope = 'outer',     -- Discard outer context if too long
    mode = 'cursor',          -- Show context based on cursor position
  },
  config = function(_, opts)
    local context = require("treesitter-context")
    context.setup(opts)

    local expanded = false
    vim.keymap.set("n", "<leader>tt", function()
      expanded = not expanded
      context.setup({
        max_lines = expanded and 8 or 1, -- toggle between 5 and 1 lines
      })
      vim.notify("Context lines: " .. (expanded and "8" or "1"))
    end, { desc = "Toggle Context Lines" })
  end,
}
