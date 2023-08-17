local present, leap = pcall(require, 'leap')

if not present then
  return
end

leap.setup({})
leap.add_default_mappings()
