-- https://github.com/CopilotC-Nvim/CopilotChat.nvim?tab=readme-ov-file#default-configuration
local prompts = {
  -- Code related prompts
  Refactor = '/COPILOT_REVIEW Please refactor the following code to improve its clarity and readability.',
  BetterNamings = '/COPILOT_REVIEW Please provide better names for the following variables and functions.',

  -- Text related prompts
  Summarize = 'Please summarize the following text.',
  Spelling = 'Please correct any grammar and spelling errors in the following text.',
  Wording = 'Please improve the grammar and wording of the following text.',
  Concise = 'Please rewrite the following text to make it more concise.',
}

return {
  {
    'zbirenbaum/copilot.lua',

    opts = {
      filetypes = {
        -- Enable Copilot for all file types
        ['*'] = true,
      },
    },
  },

  {
    'CopilotC-Nvim/CopilotChat.nvim',

    opts = function(_, opts)
      local select = require('CopilotChat.select')

      -- Add custom prompts to the default ones
      opts.prompts = prompts

      -- Override the git prompts message to avoid commitizen format
      opts.prompts.Commit = {
        prompt = 'Write commit message for the change. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.',

        selection = select.gitdiff,
      }

      opts.prompts.CommitStaged = {
        prompt = 'Write commit message for the change. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.',

        selection = function(source)
          return select.gitdiff(source, true)
        end,
      }
    end,
  },
}
