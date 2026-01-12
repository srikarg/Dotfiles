-- https://github.com/CopilotC-Nvim/CopilotChat.nvim?tab=readme-ov-file#default-configuration
local prompts = {
  -- Code related prompts
  Refactor = {
    prompt = '> /COPILOT_REVIEW\n\nPlease refactor the following code to improve its clarity and readability.',
  },
  BetterNamings = {
    prompt = '> /COPILOT_REVIEW\n\nPlease provide better names for the following variables and functions.',
  },
  Commit = {
    prompt = '> #git:staged\n\nWrite a commit message for the change. Make sure the title has a maximum of 50 characters and the message is wrapped at 72 characters. Wrap the whole message in a code block with the gitcommit language.',
  },

  -- Text related prompts
  Summarize = {
    prompt = 'Please summarize the following text.',
  },
  Spelling = {
    prompt = 'Please correct any grammar and spelling errors in the following text.',
  },
  Wording = {
    prompt = 'Please improve the grammar and wording of the following text.',
  },
  Concise = {
    prompt = 'Please rewrite the following text to make it more concise.',
  },
}

return {
  {
    'zbirenbaum/copilot.lua',

    optional = true,

    opts = {
      filetypes = {
        -- Enable Copilot for all file types
        ['*'] = true,
      },

      server_opts_overrides = {
        settings = {
          telemetry = {
            telemetryLevel = 'off',
          },
        },
      },
    },
  },

  {
    'CopilotC-Nvim/CopilotChat.nvim',

    optional = true,

    opts = {
      model = 'claude-sonnet-4',

      prompts = prompts,

      mappings = {
        -- Remove conflicting reset mapping (C-l) since it conflicts the mapping
        -- to move to the window on the right (in neovim + tmux)
        reset = {},
      },
    },
  },
}
