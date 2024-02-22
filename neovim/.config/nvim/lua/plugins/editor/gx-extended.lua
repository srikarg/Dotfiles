return {
  'rmagatti/gx-extended.nvim',

  keys = { 'gx' },

  config = function()
    require('gx-extended').setup({
      open_fn = require('lazy.util').open,

      -- Regex Character Classes in Lua Overview: https://www.lua.org/manual/5.1/manual.html#5.4.1
      extensions = {
        {
          -- This extension was initially sourced from https://github.com/rmagatti/dotfiles/blob/cac197b877883da74b6d15457fe064cd0a9d16ad/nvim/lua/rmagatti/gx-extended.lua#L8-L17
          patterns = { '*.js', '*.jsx', '*.ts', '*.tsx' },
          name = 'Go to npm package registry',
          match_to_url = function(line_string)
            local package_name =
              string.match(line_string, 'from [\'"](.-)[\'"]')
            local url = 'https://www.npmjs.com/package/' .. package_name

            return package_name and url or nil
          end,
        },

        {
          patterns = { '*.js', '*.jsx', '*.ts', '*.tsx' },
          name = 'Go to Socket.dev information on npm package',
          match_to_url = function(line_string)
            local package_name =
              string.match(line_string, 'from [\'"](.-)[\'"]')
            local url = 'https://socket.dev/npm/package/' .. package_name

            return package_name and url or nil
          end,
        },

        {
          patterns = { '*' },
          name = 'Go to JIRA',
          match_to_url = function(line_string)
            -- Match Jira tickets of form {4 uppercase/lowercase characters}-{1, 2, 3, or 4 digits} (ex. ABCD-1, ABCD-12, ABCD-123, ABCD-1234)
            local ticket = string.match(line_string, '%a%a%a%a%-%d%d?%d?%d?')
            local url = 'https://jira.jnj.com/browse/' .. ticket
            return ticket and url or nil
          end,
        },

        {
          patterns = { '*Dockerfile' },
          name = 'Go to DockerHub',
          match_to_url = function(line_string)
            -- Match the image's name in FROM lines of Dockerfiles to go to the
            -- DockerHub page for the specified image
            local docker_image = string.match(line_string, '^FROM .-([%a%d]+):')
            local url = 'https://hub.docker.com/_/' .. docker_image
            return docker_image and url or nil
          end,
        },
      },
    })
  end,
}
