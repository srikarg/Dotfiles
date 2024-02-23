vim.api.nvim_create_user_command('Browse', function(opts)
  require('lazy.util').open(opts.fargs[1])
end, { nargs = 1 })
