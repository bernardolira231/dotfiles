return {
  {
    "rmagatti/goto-preview",
    event = "BufEnter",
    opts = {
      post_open_hook = function(_, win)
        vim.keymap.set("n", "gpo", function()
          local current = vim.api.nvim_get_current_win()
          local ok, is_preview = pcall(vim.api.nvim_win_get_var, current, "is-goto-preview-window")
          if not ok or is_preview ~= 1 then
            return
          end

          local buf = vim.api.nvim_get_current_buf()
          local cursor = vim.api.nvim_win_get_cursor(current)
          local target = nil

          for _, candidate in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
            local config = vim.api.nvim_win_get_config(candidate)
            if candidate ~= current and config.relative == "" then
              target = candidate
              break
            end
          end

          if not target then
            return
          end

          vim.api.nvim_set_current_win(target)
          vim.cmd("split")
          vim.api.nvim_win_set_buf(0, buf)
          vim.api.nvim_win_set_cursor(0, cursor)
          pcall(vim.api.nvim_win_close, current, true)
        end, { buffer = true, silent = true, desc = "Open preview as split" })
      end,
    },
    keys = {
      {
        "gpd",
        function()
          require("goto-preview").goto_preview_definition()
        end,
        desc = "Preview definition",
      },
      {
        "gpi",
        function()
          require("goto-preview").goto_preview_implementation()
        end,
        desc = "Preview implementation",
      },
      {
        "gpr",
        function()
          require("goto-preview").goto_preview_references()
        end,
        desc = "Preview references",
      },
      {
        "gP",
        function()
          require("goto-preview").close_all_win()
        end,
        desc = "Close previews",
      },
    },
  },
}
