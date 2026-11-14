return {
  {
    "NickvanDyke/opencode.nvim",
    dependencies = {
      { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
    },
    keys = {
      { "<leader>a", "", desc = "+OpenCode", mode = { "n", "x" } },
      {
        "<leader>aa",
        function()
          require("opencode").toggle()
        end,
        mode = { "n" },
        desc = "Toggle OpenCode",
      },
      {
        "<leader>ab",
        function()
          require("opencode").ask("@file ", { submit = true })
        end,
        mode = { "n", "x" },
        desc = "OpenCode ask about buffer",
      },
      {
        "<leader>ai",
        function()
          require("opencode").ask("", { submit = true })
        end,
        mode = { "n", "x" },
        desc = "OpenCode ask",
      },
      {
        "<leader>aI",
        function()
          require("opencode").ask("@this: ", { submit = true })
        end,
        mode = { "n", "x" },
        desc = "OpenCode ask with context",
      },
      {
        "<leader>as",
        function()
          require("opencode").select({ submit = true })
        end,
        mode = { "n", "x" },
        desc = "OpenCode select",
      },
      {
        "<leader>ap",
        function()
          require("opencode").prompt("@this", { submit = true })
        end,
        mode = { "n", "x" },
        desc = "OpenCode prompt",
      },
      {
        "<D-a>",
        function()
          require("which-key").show({ keys = "<leader>a", mode = vim.fn.mode() })
        end,
        mode = { "n", "x" },
        desc = "OpenCode menu",
      },
    },
    config = function()
      vim.g.opencode_opts = {
        provider = {
          snacks = {
            win = {
              position = "left",
            },
          },
        },
      }
      vim.o.autoread = true
    end,
  },
}
