-- FORCE RELOAD SCRIPT
-- This will clear all cached modules and reload lite-ui
-- Run with :luafile %

print("=== FORCE RELOADING LITE-UI ===\n")

-- 1. Unload all lite-ui modules
print("1. Unloading all lite-ui modules...")
for name, _ in pairs(package.loaded) do
  if name:match("^lite%-ui") then
    print("   Unloading: " .. name)
    package.loaded[name] = nil
  end
end
print("   ✓ All modules unloaded")

-- 2. Restore original vim.ui functions temporarily
print("\n2. Restoring original vim.ui...")
local orig_input = vim.fn.input
local orig_select = vim.fn.select

-- 3. Reload lite-ui
print("\n3. Reloading lite-ui...")
local ok, err = pcall(function()
  require("lite-ui").setup({
    theme = "default",
    input = {
      auto_detect_cword = true,
      start_in_insert = true,
    }
  })
end)

if ok then
  print("   ✓ lite-ui reloaded successfully")
else
  print("   ✗ Error reloading: " .. tostring(err))
  return
end

-- 4. Verify the fix
print("\n4. Verifying...")
local input_module = require("lite-ui.input")
local source = debug.getinfo(input_module.input).source:sub(2)
local lines = vim.fn.readfile(source)

if lines[60] and lines[60]:match("nofile") then
  print("   ✓ Line 60 is correct: " .. lines[60])
else
  print("   ✗ Line 60 is WRONG: " .. (lines[60] or "NOT FOUND"))
  print("\n   PLEASE FIX: Line 60 must contain buftype = \"nofile\"")
  return
end

-- 5. Test it
print("\n5. Running test...")
print("   Opening test window...\n")

vim.schedule(function()
  vim.ui.input({
    prompt = "After Reload Test: ",
    default = "test"
  }, function(result)
    print("\n=== RESULT ===")
    if result then
      print("✓ Got result: " .. result)
      print("\nIf you saw:")
      print("  - NO '%' character")
      print("  - Text 'test' was visible")
      print("  - Cursor at the end")
      print("\nThen the fix is working!")
    else
      print("✗ Cancelled or nil result")
    end
    
    print("\n=== NEXT STEPS ===")
    print("1. Try LSP rename: Put cursor on a symbol, run :lua vim.lsp.buf.rename()")
    print("2. If still showing '%', your Neovim may have cached the OLD file")
    print("3. Solution: Completely quit Neovim (:qa!) and restart")
  end)
end)

print("\n=== IMPORTANT ===")
print("After this test, you MUST completely restart Neovim (:qa!) for changes to take full effect")
