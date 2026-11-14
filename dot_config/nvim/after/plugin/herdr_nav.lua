local function nav(wincmd, dir)
  local prev = vim.api.nvim_get_current_win()
  vim.cmd("wincmd " .. wincmd)
  if vim.api.nvim_get_current_win() ~= prev then
    return
  end

  if vim.env.HERDR_PANE_ID and vim.env.HERDR_PANE_ID ~= "" then
    local herdr = vim.env.HERDR_BIN_PATH
    if herdr == nil or herdr == "" then
      herdr = "herdr"
    end
    vim.fn.system({ herdr, "pane", "focus", "--direction", dir, "--current" })
  elseif vim.env.TMUX and vim.env.TMUX ~= "" then
    local tmux = { left = "Left", down = "Down", up = "Up", right = "Right" }
    pcall(vim.cmd, "TmuxNavigate" .. tmux[dir])
  end
end

local function apply_herdr_nav_mappings()
  local function set_nav(lhs, wincmd, dir, desc)
    pcall(vim.keymap.del, "n", lhs)
    vim.keymap.set("n", lhs, function()
      nav(wincmd, dir)
    end, { silent = true, noremap = true, desc = desc })
  end

  local function set_terminal_nav(lhs, wincmd, dir, desc)
    pcall(vim.keymap.del, "t", lhs)
    vim.keymap.set("t", lhs, function()
      local esc = vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true)
      vim.api.nvim_feedkeys(esc, "n", false)
      vim.schedule(function()
        nav(wincmd, dir)
      end)
    end, { silent = true, noremap = true, desc = desc })
  end

  set_nav("<C-h>", "h", "left", "Navigate left (vim/herdr)")
  set_nav("<C-j>", "j", "down", "Navigate down (vim/herdr)")
  set_nav("<C-k>", "k", "up", "Navigate up (vim/herdr)")
  set_nav("<C-l>", "l", "right", "Navigate right (vim/herdr)")

  set_terminal_nav("<C-S-h>", "h", "left", "Navigate left from terminal (vim/herdr)")
  set_terminal_nav("<C-S-j>", "j", "down", "Navigate down from terminal (vim/herdr)")
  set_terminal_nav("<C-S-k>", "k", "up", "Navigate up from terminal (vim/herdr)")
  set_terminal_nav("<C-S-l>", "l", "right", "Navigate right from terminal (vim/herdr)")
end

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = apply_herdr_nav_mappings,
})

apply_herdr_nav_mappings()
