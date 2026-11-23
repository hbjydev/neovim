local opencode_terminal = {
  count = 1,
  win = { position = 'right', enter = false },
}

return {
  {
    'nickvandyke/opencode.nvim',
    enabled = not Hvim.is_mini() and not Hvim.is_vscode(),
    dependencies = {
      { 'folke/snacks.nvim', opts = { input = {}, picker = {}, terminal = {} } }
    },
    keys = {
      {
        '<leader>ac',
        function()
          require('snacks.terminal').toggle('opencode', opencode_terminal)
        end,
        desc = 'Toggle OpenCode',
      },
      {
        '<leader>aa',
        function()
          require('opencode').prompt('@this: ')
        end,
        mode = { "n", "x", "v" },
        desc = 'Send context to OpenCode',
      },
    },
    config = function()
      --@type opencode.Opts
      vim.g.opencode_opts = {
        server = {
          start = function()
            require('snacks.terminal').get('opencode', opencode_terminal):show()
          end,
        },
      }

      -- Required for `opts.events.reload`
      vim.o.autoread = true
    end,
  },

  {
    'zbirenbaum/copilot.lua',
    enabled = not Hvim.is_mini() and not Hvim.is_vscode(),
    lazy = true,
    cmd = 'Copilot',
    event = 'LazyFile',
    opts = {},
  },

  {
    "saghen/blink.cmp",
    dependencies = { "fang2hou/blink-copilot" },
    opts = {
      sources = {
        default = { 'copilot' },
        providers = {
          copilot = {
            name = "copilot",
            module = "blink-copilot",
            score_offset = 100,
            async = true,
          }
        }
      }
    }
  },

  {
    'ravitemer/mcphub.nvim',
    enabled = not Hvim.is_mini() and not Hvim.is_vscode(),
    lazy = true,
    cmd = 'MCPHub',
    event = 'LazyFile',
    keys = {{ '<leader>am', ':MCPHub<CR>', desc = 'Open MCPHub' }},
    dependencies = { "nvim-lua/plenary.nvim" },
    build = 'bun install --global mcp-hub@latest',
    opts = {
      extensions = {
        copilotchat = {
          enabled = true,
          convert_tools_to_functions = true,
          convert_resources_to_functions = true,
          add_mcp_prefix = false,
        },
      },
    },
  }
}
