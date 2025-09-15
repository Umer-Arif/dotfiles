local M = {}

function M.run(cmd)
  local file = vim.fn.expand("%:p")
  local full_cmd = string.format(cmd, file)

  vim.notify("Running: " .. full_cmd, vim.log.levels.INFO)

  vim.cmd("belowright split")
  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(win, buf)

  vim.fn.termopen(full_cmd, {
    on_exit = function(_, exit_code, _)
      vim.notify("Process exited with code: " .. exit_code, vim.log.levels.INFO)
    end,
  })
end

return M

