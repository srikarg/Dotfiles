return {
  'neovim/nvim-lspconfig',

  opts = {
    servers = {
      denols = {
        settings = {
          deno = {
            enable = true,
            lint = true,
            unstable = true,
            suggest = {
              imports = {
                autoDiscover = true,
                hosts = {
                  ['https://deno.land'] = true,
                },
              },
            },
          },
        },
      },
    },
  },
}
