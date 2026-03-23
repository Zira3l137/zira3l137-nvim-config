---@module 'lazy'
---@type LazySpec
return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require('lualine').setup({
            options = {
                theme = 'horizon',
                icons_enabled = vim.g.have_nerd_font,
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff', 'diagnostics' },
                lualine_c = { 'filename', 'filesize' },
                lualine_x = { 'encoding', 'fileformat', 'filetype', 'lsp_status' },
                lualine_y = { 'progress' },
                lualine_z = { 'location' }
            },
        })
    end,
}
