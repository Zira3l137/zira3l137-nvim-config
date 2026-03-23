-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic Config & Keymaps
-- See :help vim.diagnostic.Opts

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

vim.keymap.set('n', '<leader>tv', function()
    local current_value = vim.diagnostic.config().virtual_lines
    vim.diagnostic.config({ virtual_lines = not current_value })
end, { desc = 'Toggle Diagnostic Virtual Text' })

vim.keymap.set('n', 'gl', function()
    vim.diagnostic.open_float(nil, {
        focus = false,
        scope = "cursor",  -- "line" shows all on line, "cursor" only the specific error
        border = "rounded",
        source = "always", -- Shows if it's from Clippy, Ruff, etc.
    })
end, { desc = 'Show floating diagnostics' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })
vim.keymap.set('n', '<C-q>', '<C-w>q', { desc = 'Close window' })

vim.keymap.set('n', '<leader>c', ':bd<CR>', { desc = 'Close buffer' })

vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("n", "<C-s>", ":w<CR>", { desc = "Save file" })
vim.keymap.set("n", "gd", ":lua vim.lsp.buf.definition()<CR>", { desc = "Go to definition" })
vim.keymap.set("n", "\\", ":split<CR>", { desc = "Split window" })
vim.keymap.set("n", "|", ":vsplit<CR>", { desc = "Split window" })

vim.keymap.set("n", "<leader>pm", ":Mason<CR>", { desc = "Open Mason" })
vim.keymap.set("n", "<leader>pl", ":Lazy<CR>", { desc = "Open Lazy" })

vim.keymap.set("n", "<leader>/", "gcc", { remap = true, desc = "Comment line" })
vim.keymap.set("v", "<leader>/", "gc", { remap = true, desc = "Comment selection" })
