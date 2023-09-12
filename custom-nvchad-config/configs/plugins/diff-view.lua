local present, diffview = pcall(require, 'diffview')

if not present then
  return
end

diffview.setup({
  enhanced_diff_hl = true,
  view = {
    merge_tool = {
      layout = 'diff3_mixed',
      disable_diagnostics = true,
    },
  },
})
