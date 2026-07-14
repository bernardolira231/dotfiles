return {
  {
    "okuuva/auto-save.nvim",
    event = { "InsertLeave", "TextChanged" },
    opts = {
      enabled = true,
      trigger_events = {
        immediate_save = { "BufLeave", "FocusLost" },
        defer_save = { "InsertLeave", "TextChanged" },
        cancel_deferred_save = { "InsertEnter" },
      },
      condition = function(buf)
        local bt = vim.bo[buf].buftype
        local ft = vim.bo[buf].filetype
        if bt ~= "" then
          return false
        end
        if ft == "" then
          return false
        end
        if ft == "lazygit" or ft == "TelescopePrompt" or ft == "snacks_picker_input" then
          return false
        end
        return vim.bo[buf].modifiable and vim.bo[buf].modified
      end,
    },
  },
}
