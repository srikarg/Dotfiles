local present, gx_extended = pcall(require, 'gx-extended')

if not present then
  return
end

gx_extended.setup({
  open_fn = require('lazy.util').open,
  extensions = {
    {
      patterns = { '*' },
      name = 'JIRA tickets',
      match_to_url = function(line_string)
        -- Regex Character Classes in Lua Overview: https://www.lua.org/manual/5.1/manual.html#5.4.1
        -- Match Jira tickets of form {4 uppercase/lowercase characters}-{1, 2, 3, or 4 digits} (ex. ABCD-1, ABCD-12, ABCD-123, ABCD-1234)
        local ticket = string.match(line_string, '%a%a%a%a%-%d%d?%d?%d?')
        local url = 'https://jira.jnj.com/browse/' .. ticket
        return ticket and url or nil
      end,
    },
  },
})
