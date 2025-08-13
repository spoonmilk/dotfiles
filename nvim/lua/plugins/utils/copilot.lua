return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
  opts = {
    server_opts_overrides = {
      settings = {
        telemetry = {
          telemetryLevel = 'off',
        },
      },
    },
  },
  config = function()
    require('copilot').setup {}
  end,
}
