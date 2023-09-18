local present, flash = pcall(require, 'flash')

if not present then
  return
end

flash.setup()
