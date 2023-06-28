local W = {}

function W.commit(command)
  vim.cmd(":G add .")
  vim.cmd(":G commit -m 'WIP'")
  vim.cmd(":G push")
end


return W

