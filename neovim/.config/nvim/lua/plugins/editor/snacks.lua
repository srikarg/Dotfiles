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
          file = '/blob/{branch}/{file}#L{line}',
        },
        ['gitlab%.com'] = {
          branch = '/-/tree/{branch}',
          file = '/-/blob/{branch}/{file}#L{line}',
        },
        ['bitbucket%.org'] = {
          branch = '/src/{branch}',
          file = '/src/{branch}/{file}#lines-{line}',
          commit = '/commits/{commit}',
        },
        ['sourcecode%.jnj%.com'] = {
          branch = '/compare/commits?sourceBranch=refs%2Fheads%2F{branch}&targetBranch=refs%2Fheads%2Fdevelop',
          file = '/browse/{file}?at=refs%2Fheads%2F{branch}#{line}',
          commit = '/commits/{commit}',
        },
      },
    },
  },
}
