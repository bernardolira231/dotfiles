return {
  { import = "lazyvim.plugins.extras.lang.typescript" },

  -- Swift: sourcekit-lsp ships with Xcode (not installable via Mason).
  -- Xcode projects need a buildServer.json (xcode-build-server) at the repo root.
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        sourcekit = {
          mason = false,
          cmd = { "xcrun", "sourcekit-lsp" },
          filetypes = { "swift", "objc", "objcpp" },
          root_markers = { "buildServer.json", "Package.swift", ".git" },
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "swift" } },
  },
}
