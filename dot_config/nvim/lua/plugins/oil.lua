return {
  {
    "stevearc/oil.nvim",
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
      {
        "<leader>E",
        function()
          require("oil").open_float()
        end,
        desc = "Open Oil (float)",
      },
      {
        "<leader>o",
        function()
          require("oil").open_float()
        end,
        desc = "Open Oil (float)",
      },
    },
    opts = {
      default_file_explorer = true,
      view_options = {
        show_hidden = true,
        is_always_hidden = function(name)
          return name == ".git"
        end,
      },
      float = {
        padding = 2,
        max_width = 100,
        max_height = 30,
        border = "rounded",
      },
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-s>"] = { "actions.select", opts = { vertical = true }, desc = "Open in vertical split" },
        ["<C-v>"] = { "actions.select", opts = { horizontal = true }, desc = "Open in horizontal split" },
        ["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open in new tab" },
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = "actions.close",
        ["<C-r>"] = "actions.refresh",
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["g."] = "actions.toggle_hidden",
        ["q"] = "actions.close",
      },
      use_default_keymaps = false,
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
}
