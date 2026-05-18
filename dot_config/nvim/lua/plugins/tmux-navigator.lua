return {
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    init = function()
      vim.g.tmux_navigator_no_mappings = 1
      vim.g.tmux_navigator_disable_netrw_workaround = 1
    end,
    keys = {
      {
        "<C-h>",
        function()
          local current = vim.api.nvim_get_current_win()
          vim.cmd.wincmd("h")
          if vim.api.nvim_get_current_win() == current and vim.env.TMUX then
            vim.fn.system({ "tmux", "select-pane", "-L" })
          end
        end,
        mode = "n",
        desc = "Window Left",
      },
      {
        "<C-j>",
        function()
          local current = vim.api.nvim_get_current_win()
          vim.cmd.wincmd("j")
          if vim.api.nvim_get_current_win() == current and vim.env.TMUX then
            vim.fn.system({ "tmux", "select-pane", "-D" })
          end
        end,
        mode = "n",
        desc = "Window Down",
      },
      {
        "<C-k>",
        function()
          local current = vim.api.nvim_get_current_win()
          vim.cmd.wincmd("k")
          if vim.api.nvim_get_current_win() == current and vim.env.TMUX then
            vim.fn.system({ "tmux", "select-pane", "-U" })
          end
        end,
        mode = "n",
        desc = "Window Up",
      },
      {
        "<C-l>",
        function()
          local current = vim.api.nvim_get_current_win()
          vim.cmd.wincmd("l")
          if vim.api.nvim_get_current_win() == current and vim.env.TMUX then
            vim.fn.system({ "tmux", "select-pane", "-R" })
          end
        end,
        mode = "n",
        desc = "Window Right",
      },
      {
        "<C-\\>",
        function()
          if vim.env.TMUX then
            vim.fn.system({ "tmux", "select-pane", "-l" })
          end
        end,
        mode = "n",
        desc = "Window Previous",
      },
    },
  },
}
