-- LSP Plugins
---@module 'lazy'
---@type LazySpec
return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
    },
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('<leader>lr', vim.lsp.buf.rename, '[R]ename')
          map('<leader>la', vim.lsp.buf.code_action, 'Code [A]ction', { 'n', 'x' })
          map('<leader>lD', vim.lsp.buf.declaration, 'Goto [D]eclaration')

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method('textDocument/documentHighlight', event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })
            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          if client and client:supports_method('textDocument/inlayHint', event.buf) then
            map('<leader>th',
              function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end,
              '[T]oggle Inlay [H]ints')
          end
        end,
      })

      require('mason-lspconfig').setup {
        automatic_enable = true,
      }

      -- Load per-tool configs from lua/tools/*.lua
      -- Drop a file there to configure any LSP or tool installed via :Mason
      local tools_dir = vim.fn.stdpath 'config' .. '/lua/tools'
      if vim.fn.isdirectory(tools_dir) == 1 then
        for _, file in ipairs(vim.fn.readdir(tools_dir)) do
          local name = file:match '^(.+)%.lua$'
          if name then require('tools.' .. name) end
        end
      end
    end,
  },
}
