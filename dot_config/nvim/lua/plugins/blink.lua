return {
  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        ghost_text = {
          enabled = true,
        },
      },
      sources = {
        default = { "lsp", "snippets", "path", "buffer" },
        per_filetype = {
          javascriptreact = { inherit_defaults = true, "lsp", "snippets", "path", "buffer" },
          typescriptreact = { inherit_defaults = true, "lsp", "snippets", "path", "buffer" },
        },
      },
    },
  },
}
