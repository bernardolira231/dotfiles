return {
  -- Add the OneDark Pro plugin
  {
    "olimorris/onedarkpro.nvim",
    --priority = 1000, -- Ensure it loads first
  },

  -- Configure LazyVim to use the onedark colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "kanagawa-dragon",
    },
  },
}
