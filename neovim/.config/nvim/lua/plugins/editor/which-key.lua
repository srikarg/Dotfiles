return {
  'folke/which-key.nvim',

  event = 'VeryLazy',

  config = function()
    require('which-key').setup({
      plugins = {
        spelling = true,
      },
    })

    -- document existing key chains
    require('which-key').register({
      ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
      ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
      ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
      ['<leader>h'] = { name = 'More git', _ = 'which_key_ignore' },
      ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
      ['<leader>f'] = { name = '[F]ind', _ = 'which_key_ignore' },
      ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
      ['<leader>q'] = { name = 'Diagnostics', _ = 'which_key_ignore' },
    })
  end,
}
