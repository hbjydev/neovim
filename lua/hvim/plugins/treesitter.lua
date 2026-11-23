local runtime = vim.fn.stdpath('data') .. '/tree-sitter-manager'

return {
  {
    'romus204/tree-sitter-manager.nvim',
    enabled = not Hvim.is_mini(),
    lazy = false,
    opts = {
      parser_dir = runtime .. '/parser',
      query_dir = runtime .. '/queries',
      ensure_installed = {
        'bash', 'diff', 'go', 'html', 'javascript', 'jsdoc', 'json', 'kdl',
        'luadoc', 'printf', 'python', 'regex', 'toml', 'tsx', 'typescript',
        'xml', 'yaml',
      },
    },
    config = function(_, opts)
      require('tree-sitter-manager').setup(opts)
      vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      vim.opt.foldmethod = 'expr'
    end,
  },
}
