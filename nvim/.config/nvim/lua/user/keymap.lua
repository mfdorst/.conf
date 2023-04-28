-- Map leader to <space>
vim.g.mapleader = ' '

-- Unmap keys we don't want
vim.keymap.set('n', 's', '<nop>')
vim.keymap.set('n', '<space>', '<nop>')
vim.keymap.set('n', '<cr>', '<nop>')
vim.keymap.set('n', 't', '<nop>')
vim.keymap.set('n', 'Q', '<nop>')

-- Pressing j and k together goes to normal mode
vim.keymap.set('i', 'jk', '<esc>')
vim.keymap.set('i', 'kj', '<esc>')

-- Jump to beginning/end of line
vim.keymap.set({ 'n', 'v' }, 'H', '0')
vim.keymap.set({ 'n', 'v' }, 'L', '$')

-- Create splits
vim.keymap.set('n', '<leader>sv', ':vsplit<cr>')
vim.keymap.set('n', '<leader>sh', ':split<cr>')

-- Move between splits
vim.keymap.set('n', '<leader>j', '<C-w>j')
vim.keymap.set('n', '<leader>k', '<C-w>k')
vim.keymap.set('n', '<leader>h', '<C-w>h')
vim.keymap.set('n', '<leader>l', '<C-w>l')

-- Close quickfix menu
vim.keymap.set('n', 'sq', ':cclose<cr>')

-- Move highlighted lines up or down
vim.keymap.set('v', 'J', [[:m '>+1<cr>gv=gv]])
vim.keymap.set('v', 'K', [[:m '<-2<cr>gv=gv]])

-- Keep cursor in the middle when half-page jumping
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Keep search terms in the middle of the screen
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzv')

-- Paste over something without losing your paste buffer
vim.keymap.set('x', '<C-p>', '"_dP')

-- Copy/cut/paste to/from system clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>p', '"+p')
vim.keymap.set({ 'n', 'v' }, '<leader>P', '"+P')
vim.keymap.set({ 'n', 'v' }, '<leader>d', '"+d')
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y')
vim.keymap.set('n', '<leader>Y', '"+Y')

-- Search and replace word under cursor
vim.keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Redo
vim.keymap.set('n', 'R', '<C-r>')

-- Stay in visual mode after indent
vim.keymap.set('v', '>', '>gv')
vim.keymap.set('v', '<', '<gv')

-- Terminal mode - go to Normal mode
vim.keymap.set('t', '<esc>', [[<C-\><C-N>]])

-- Plugins

-- LSP functions
local lsp_ok, lsp = pcall(require, 'lsp-zero')
if lsp_ok then
    lsp.on_attach(function()
        vim.keymap.set('n', '<leader>rf', vim.lsp.buf.format)
        vim.keymap.set('n', 'ss', vim.lsp.buf.hover)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename)
        vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help)
    end)
end

-- Nvim Tree
local nvim_tree_ok, nvim_tree = pcall(require, 'nvim-tree')
if not nvim_tree_ok then
    -- Open netrw
    vim.keymap.set('n', '<leader>f', vim.cmd.Ex)
else
    vim.keymap.set('n', '<leader>f', ':NvimTreeToggle<cr>')

    nvim_tree.setup({
        on_attach = function(bufnr)
            local api = require('nvim-tree.api')

            api.config.mappings.default_on_attach(bufnr)
            local opts = { buffer = bufnr }

            -- Unmap keys
            vim.keymap.set('n', 's', '', opts)
            vim.keymap.del('n', 's', opts)
            vim.keymap.set('n', 'q', '', opts)
            vim.keymap.del('n', 'q', opts)
        end
    })
end

-- Harpoon
local mark_ok, mark = pcall(require, 'harpoon.mark')
local ui_ok, ui = pcall(require, 'harpoon.ui')
if mark_ok and ui_ok then
    vim.keymap.set('n', '<leader>a', mark.add_file)
    vim.keymap.set('n', 'sh', ui.toggle_quick_menu)

    vim.keymap.set('n', '<leader>1', function() ui.nav_file(1) end)
    vim.keymap.set('n', '<leader>2', function() ui.nav_file(2) end)
    vim.keymap.set('n', '<leader>3', function() ui.nav_file(3) end)
    vim.keymap.set('n', '<leader>4', function() ui.nav_file(4) end)
    vim.keymap.set('n', '<leader>5', function() ui.nav_file(5) end)
    vim.keymap.set('n', '<leader>6', function() ui.nav_file(6) end)
    vim.keymap.set('n', '<leader>7', function() ui.nav_file(7) end)
    vim.keymap.set('n', '<leader>8', function() ui.nav_file(8) end)
end

-- Fugitive
vim.keymap.set('n', 'gs', vim.cmd.Git)

-- Telescope
local ts_ok, ts_builtin = pcall(require, 'telescope.builtin')
if ts_ok then
    vim.keymap.set('n', '<leader>ff', ts_builtin.find_files)
    vim.keymap.set('n', '<leader>fg', ts_builtin.git_files)
    vim.keymap.set('n', '<leader>fs', ts_builtin.grep_string)
end

-- Toggleterm
vim.keymap.set('n', 'tt', ':ToggleTerm<cr>')

-- Undotree
vim.keymap.set('n', 'su', vim.cmd.UndotreeToggle)

-- Cmp: see ../../after/plugin/lsp.lua

-- Custom scripts
local extra = require('user.extra')
vim.keymap.set('n', 'st', extra.toggle_inlay_hints)
