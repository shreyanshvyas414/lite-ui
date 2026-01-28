local M = {}

-- Lazy loading support: if called before other modules are loaded, defer setup
local config = require("lite-ui.config")
local themes = require("lite-ui.themes")

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

  -- Create user commands for theme management
  vim.api.nvim_create_user_command("LiteUITheme", function(opts)
    local theme_name = opts.args
    if theme_name == "" then
      -- List available themes
      local available = themes.list_themes()
      vim.notify("Available themes: " .. table.concat(available, ", "), vim.log.levels.INFO)
    else
      -- Apply theme
      themes.apply_theme(theme_name)
      config.options.theme = theme_name
      vim.notify("Applied theme: " .. theme_name, vim.log.levels.INFO)
    end
  end, {
    nargs = "?",
    complete = function()
      return themes.list_themes()
    end,
    desc = "Change lite-ui theme or list available themes",
  })

  -- Command to demo the UI
  vim.api.nvim_create_user_command("LiteUIDemo", function()
    -- Demo input
    vim.ui.input({ prompt = "Enter your name: ", default = "User" }, function(name)
      if name then
        -- Demo select
        vim.ui.select(
          { "Option 1", "Option 2", "Option 3", "Option 4", "Option 5" },
          { prompt = "Select an option:" },
          function(choice)
            if choice then
              vim.notify(string.format("Hello %s! You selected: %s", name, choice), vim.log.levels.INFO)
            end
          end
        )
      end
    end)
  end, { desc = "Demo lite-ui input and select" })
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

-- Expose themes API
M.themes = themes

return M
