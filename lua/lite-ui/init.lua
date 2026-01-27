local M = {}

local config = require("lite-ui.config")

-- Store originals for potential restoration
M._original_input = nil
M._original_select = nil

function M.setup(opts)
  -- Setup configuration
  config.setup(opts)

  -- Store originals (for potential restoration)
  M._original_input = M._original_input or vim.ui.input
  M._original_select = M._original_select or vim.ui.select

  -- Override vim.ui functions
  vim.ui.input = function(input_opts, on_confirm)
    require("lite-ui.input").input(input_opts, on_confirm)
  end

  vim.ui.select = function(items, select_opts, on_choice)
    require("lite-ui.select").select(items, select_opts, on_choice)
  end
end

-- Optional: Function to restore original vim.ui functions
function M.restore()
  if M._original_input then
    vim.ui.input = M._original_input
  end
  if M._original_select then
    vim.ui.select = M._original_select
  end
end

return M
