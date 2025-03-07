return {
  "rebelot/kanagawa.nvim",
  enabled = true,
  version = false,
  lazy = false,
  priority = 5001, -- make sure to load this before all the other start plugins
  -- Optional; default configuration will be used if setup isn't called.
  config = function()
    require("kanagawa").setup({
      -- Your config here
      theme = "dragon",
    })
    vim.cmd([[colorscheme kanagawa-dragon]])
  end,
}
