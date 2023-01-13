if pcall(require, "plenary") then

  reload = require("plenary.reload").reload_module

  function _G.reload_nvim_conf()
    for name,_ in pairs(package.loaded) do
      if name:match('^user')
      then
        reload(name)
      end
    end

    dofile(vim.env.MYVIMRC)
    vim.notify("Nvim configuration reloaded!", vim.log.levels.INFO)
  end
else
  function _G.reload_nvim_conf()
    vim.notify("plenary is required...", vim.log.levels.ERROR)
  end
end
