-- DIAGNOSTIC SCRIPT
-- Run with :luafile %
-- This will tell us exactly what's wrong

print("=== LITE-UI DIAGNOSTIC ===\n")

-- 1. Check if lite-ui is loaded
print("1. Checking if lite-ui is loaded...")
local loaded, lite_ui = pcall(require, "lite-ui")
if loaded then
  print("   ✓ lite-ui is loaded")
else
  print("   ✗ lite-ui NOT loaded: " .. tostring(lite_ui))
  return
end

-- 2. Check which file is being used
print("\n2. Checking which input.lua file is being used...")
local input_loaded, input_module = pcall(require, "lite-ui.input")
if input_loaded then
  local source = debug.getinfo(input_module.input).source
  print("   File: " .. source:sub(2))
  
  -- Read and check line 60
  local lines = vim.fn.readfile(source:sub(2))
  print("   Line 60: " .. (lines[60] or "NOT FOUND"))
  
  if lines[60] and lines[60]:match("nofile") then
    print("   ✓ Correct: uses 'nofile'")
  else
    print("   ✗ WRONG: does NOT use 'nofile'")
  end
else
  print("   ✗ input module NOT loaded")
  return
end

-- 3. Test word detection
print("\n3. Testing word under cursor...")
local word = vim.fn.expand("<cword>")
print("   Current word: '" .. word .. "'")

-- 4. Test vim.ui.input override
print("\n4. Checking vim.ui.input override...")
local ui_input_source = debug.getinfo(vim.ui.input).source
print("   vim.ui.input source: " .. ui_input_source)

-- 5. Create a test
print("\n5. Running live test...")
print("   Opening input window with 'hello' as default...")
print("   CHECK: Does it show '%' character? Does it show 'hello'?")
print("")

vim.ui.input({
  prompt = "TEST INPUT: ",
  default = "hello"
}, function(result)
  print("\n=== TEST RESULT ===")
  print("You entered: " .. vim.inspect(result))
  
  if result == "hello" then
    print("✓ Default text preserved correctly")
  else
    print("✗ Default text changed or lost")
  end
end)

print("\n=== WHAT TO CHECK IN THE WINDOW ===")
print("1. Is there a '%' character? (should be NO)")
print("2. Does it show 'hello'? (should be YES)")
print("3. Is cursor at the end? (should be YES)")
print("4. Can you immediately type/backspace? (should be YES)")
print("\n=== AFTER CHECKING ===")
print("Press Enter or Esc in the window to continue...")
