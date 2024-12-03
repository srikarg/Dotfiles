return {
  'folke/snacks.nvim',

  opts = {
    gitbrowse = {
      remote_patterns = {
        { '^(https?://sourcecode%.jnj%.com)/scm/(.-)/(.+)%.git$', '%1/projects/%2/repos/%3' },
        { '^(https?://.*)%.git$', '%1' },
        { '^git@(.+):(.+)%.git$', 'https://%1/%2' },
        { '^git@(.+):(.+)$', 'https://%1/%2' },
        { '^git@(.+)/(.+)$', 'https://%1/%2' },
        { '^ssh://git@(.*)$', 'https://%1' },
        { '^ssh://([^:/]+)(:%d+)/(.*)$', 'https://%1/%3' },
        { '^ssh://([^/]+)/(.*)$', 'https://%1/%2' },
        { 'ssh%.dev%.azure%.com/v3/(.*)/(.*)$', 'dev.azure.com/%1/_git/%2' },
        { '^https://%w*@(.*)', 'https://%1' },
        { '^git@(.*)', 'https://%1' },
        { ':%d+', '' },
        { '%.git$', '' },
      },
      url_patterns = {
        ['github%.com'] = {
          branch = '/tree/{branch}',
          file = '/blob/{branch}/{file}#L{line_start}-L{line_end}',
          commit = '/commit/{commit}',
        },
        ['gitlab%.com'] = {
          branch = '/-/tree/{branch}',
          file = '/-/blob/{branch}/{file}#L{line_start}-L{line_end}',
          commit = '/-/commit/{commit}',
        },
        ['bitbucket%.org'] = {
          branch = '/src/{branch}',
          file = '/src/{branch}/{file}#lines-{line_start}-L{line_end}',
          commit = '/commits/{commit}',
        },
        ['sourcecode%.jnj%.com'] = {
          branch = '/compare/commits?sourceBranch=refs%2Fheads%2F{branch}&targetBranch=refs%2Fheads%2Fdevelop',
          file = '/browse/{file}?at=refs%2Fheads%2F{branch}#{line_start}-{line_end}',
          commit = '/commits/{commit}',
        },
      },
    },

    scratch = {
      win_by_ft = {
        typescript = {
          keys = {
            ['source'] = {
              '<cr>',
              function(self)
                local command = { 'deno', vim.api.nvim_buf_get_name(self.buf) }
                local result = vim.system(command, { text = true }):wait()
                Snacks.notify.info(result.stdout)
              end,
              desc = 'Source buffer',
              mode = { 'n', 'x' },
            },
          },
        },
      },
    },
  },
}
