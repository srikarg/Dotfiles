vim.filetype.add({
  filename = {
    Brewfile = 'ruby',
    justfile = 'just',
    Justfile = 'just',
    Tmuxfile = 'tmux',
    ['go.sum'] = 'go',
    ['.sequelizerc'] = 'javascript',
    ['yarn.lock'] = 'yaml',
    ['.env'] = 'dotenv',
    ['.sh'] = 'bash',
  },
  pattern = {
    ['%.env%.%w+'] = 'dotenv',
    ['.*%.postman_collection'] = 'json',
    ['Jenkinsfile.*'] = 'groovy',
    ['%.kube/config'] = 'yaml',
    ['%.config/git/users/.*'] = 'gitconfig',
    ['.*/templates/.*%.ya?ml'] = 'helm',
    ['.*/templates/.*%.tpl'] = 'helm',
  },
})
