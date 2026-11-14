-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("i", "aa", "<Esc>", { desc = "Salir del modo insertar aa" })

vim.keymap.set("n", "<leader>;", function()
  Snacks.dashboard.open()
end, { desc = "Abrir dashboard" })

vim.keymap.set("n", "<leader>sj", function()
  if vim.bo.filetype ~= "json" then
    vim.notify("JSON sort only works in json buffers", vim.log.levels.WARN)
    return
  end

  local input = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
  local result = vim.fn.system({ "jq", "-S", "." }, input)

  if vim.v.shell_error ~= 0 then
    vim.notify(result, vim.log.levels.ERROR)
    return
  end

  local lines = vim.split(vim.trim(result), "\n", { plain = true })
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end, { desc = "Sort JSON with jq" })

vim.keymap.set("v", "<leader>sg", function()
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local lines = vim.fn.getline(start_pos[2], end_pos[2])

  if #lines == 0 then
    return
  end

  if #lines == 1 then
    lines[1] = string.sub(lines[1], start_pos[3], end_pos[3])
  else
    lines[1] = string.sub(lines[1], start_pos[3])
    lines[#lines] = string.sub(lines[#lines], 1, end_pos[3])
  end

  local selected_text = table.concat(lines, "\n")
  selected_text = vim.fn.escape(selected_text, "\\.*[]^$()+?{}")
  require("snacks").picker.grep({ search = selected_text })
end, { desc = "Grep selected text" })

local function clear_current_terminal()
  if vim.bo.buftype ~= "terminal" then
    return
  end

  local job = vim.b.terminal_job_id
  if job then
    vim.fn.chansend(job, "clear\n")
  end
end

vim.keymap.set({ "n", "t" }, "<leader>tc", function()
  if vim.fn.mode() == "t" then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), "n", false)
  end
  clear_current_terminal()
end, { desc = "Clear terminal" })
