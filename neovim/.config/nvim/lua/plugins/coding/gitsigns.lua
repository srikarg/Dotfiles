-- Override default gitsigns config to configure hunk navigation to work for
-- both staged and unstaged hunks, instead of the default unstaged only.
return {
  'lewis6991/gitsigns.nvim',

  ---@module 'gitsigns'
  ---@param _ LazyPlugin
  ---@param opts Gitsigns.Config
  opts = function(_, opts)
    local default_on_attach = opts.on_attach
    opts.on_attach = function(buffer)
      local gs = require('gitsigns')

      -- Run LazyVim's default on_attach first, if defined
      -- https://github.com/LazyVim/LazyVim/blob/83468be35062d06896c233d90d2f1c1cd24d84f3/lua/lazyvim/plugins/editor.lua#L152
      if default_on_attach then
        default_on_attach(buffer)
      end

      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc, silent = true })
      end

      -- stylua: ignore start
      map("n", "]h", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          gs.nav_hunk("next", {
            target = "all"
          })
        end
      end, "Next Hunk")

      map("n", "[h", function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
        else
          gs.nav_hunk("prev", {
            target = "all"
          })
        end
      end, "Prev Hunk")

      map("n", "]H", function() gs.nav_hunk("last", {
        target = "all"
      }) end, "Last Hunk")

      map("n", "[H", function() gs.nav_hunk("first", {
        target = "all"
      }) end, "First Hunk")
    end

    -- Enable current line blame by default
    opts.current_line_blame = true

    return opts
  end,
}
