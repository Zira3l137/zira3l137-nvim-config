# Adding a new plugin

Simply add the plugin to the `lua/plugins` directory. Example:
```lua lua/plugins/nu.lua
return {
  'LhKipp/nvim-nu',
  build = ':TSInstall nu',
  opts = {},
}
```

# Adding and enabling language tools with Mason

Install any tool of your choice with `:MasonInstall` or any other way using Mason.

## For linters

Enable installed linters for the corresponding file type in `lua/plugins/lint.lua`. Example:
```lua lua/plugins/lint.lua
return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local lint = require 'lint'
    lint.linters_by_ft = {
      markdown = { 'markdownlint' },
      python = { 'ruff' },
      -- add more
    }
    -- ......
```

## For formatters

Enable installed formatters for the corresponding file type in `lua/plugins/conform.lua`. Example:

```lua lua/plugins/conform.lua
return {
  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    -- ...
    
    formatters_by_ft = {
      lua = { 'stylua' },
      -- Conform can also run multiple formatters sequentially
      python = { 'isort', 'pyink' },
      rust = { 'rustfmt' },
      nu = { 'nufmt' },
      -- add more
    },
    -- ...
```
