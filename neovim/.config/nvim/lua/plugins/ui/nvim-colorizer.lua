return {
  'NvChad/nvim-colorizer.lua',

  opts = {
    filetypes = {
      '*',
      cmp_docs = { always_update = true },
      cmp_menu = { always_update = true },
    },
    user_default_options = {
      names = true,
      RRGGBBAA = true,
      rgb_fn = true,
      tailwind = true,
      RGB = true,
      RRGGBB = true,
      AARRGGBB = true,
      hsl_fn = true,
      css = true,
      css_fn = true,
      mode = 'background',
      sass = { enable = true, parsers = { 'css' } },
      virtualtext = '■',
      always_update = true,
    },
  },
}
