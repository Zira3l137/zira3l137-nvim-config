return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    require('toggleterm').setup {
      open_mapping = [[<F7>]],
      autochdir = true,
      direction = 'float',
      float_opts = {
        border = 'curved',
      },
    }
  end,
}
