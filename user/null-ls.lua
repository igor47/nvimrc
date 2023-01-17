local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.diagnostics.eslint.with({
      method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
    }),
  },
})
