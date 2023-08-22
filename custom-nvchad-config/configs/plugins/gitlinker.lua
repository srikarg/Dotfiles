local present, gitlinker = pcall(require, 'gitlinker')

if not present then
  return
end

gitlinker.setup({
  mappings = nil,
  callbacks = {
    -- Example Link: https://sourcecode.jnj.com/projects/XYZ-ABCD/repos/example-repo-name/browse/example/path/here?at=exampleRevisionId#<starting line>-<ending line>
    ['sourcecode.jnj.com'] = function(url_data)
      local repo_parts = {}

      for part in string.gmatch(url_data.repo, '([^/]+)') do
        table.insert(repo_parts, part)
      end

      local url = 'https://'
        .. url_data.host
        .. '/projects/'
        .. repo_parts[2]
        .. '/repos/'
        .. repo_parts[3]
        .. '/browse/'
        .. url_data.file
        .. '?at='
        .. url_data.rev
      if url_data.lstart then
        url = url .. '#' .. url_data.lstart
        if url_data.lend then
          url = url .. '-' .. url_data.lend
        end
      end
      return url
    end,
  },
})
