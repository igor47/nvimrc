local copilot_status_ok, copilot = pcall(require, "copilot")
if not copilot_status_ok then
  return
end

copilot.setup({
  panel = { enabled = false },
  suggestion = { enabled = false },
  filetypes = {
    sh = function ()
      if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), '^%.env.*') then
        -- disable for .env files
        return false
      end
      return true
    end,
  },
})

require("copilot_cmp").setup({
  formatters = {
    insert_text = require("copilot_cmp.format").remove_existing
  },
})

vim.api.nvim_set_hl(0, "CmpItemKindCopilot", {fg ="#6CC644"})
