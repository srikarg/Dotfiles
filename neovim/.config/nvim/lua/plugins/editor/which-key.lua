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
      ['<leader>h'] = { name = 'More Git', _ = 'which_key_ignore' },
      ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
      ['<leader>f'] = { name = '[F]ind', _ = 'which_key_ignore' },
      ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
      ['<leader>t'] = { name = '[T]esting', _ = 'which_key_ignore' },
      ['<leader>s'] = { name = '[S]how Messages', _ = 'which_key_ignore' },
      ['<leader>u'] = { name = 'Toggle Settings', _ = 'which_key_ignore' },
      ['<leader>x'] = { name = 'Lists', _ = 'which_key_ignore' },
    })
  end,
}
