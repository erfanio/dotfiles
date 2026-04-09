vim.pack.add({
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/nvim-neo-tree/neo-tree.nvim",
    "https://github.com/MunifTanjim/nui.nvim",
    "https://github.com/nvim-telescope/telescope.nvim",
    "https://github.com/nvim-lualine/lualine.nvim",
    "https://github.com/tpope/vim-abolish",
    "https://github.com/tpope/vim-surround",
    "https://github.com/tpope/vim-commentary",
    "https://github.com/tpope/vim-repeat",
    "https://github.com/christoomey/vim-tmux-navigator",
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/tomasr/molokai",
})

-----------
-- Options
-----------

-- 4 space indent
vim.opt.shiftwidth  = 4
vim.opt.expandtab   = true
-- Search
vim.opt.ignorecase  = true
vim.opt.hlsearch    = true
vim.opt.incsearch   = true
vim.opt.magic       = true
-- Misc
vim.opt.undofile    = true
vim.opt.scrolloff   = 10
vim.opt.number      = true
vim.opt.mouse       = "a"
vim.opt.errorbells  = false
vim.opt.visualbell  = false
vim.opt.whichwrap:append("<,>,h,l,[,]")

vim.cmd("color molokai")

-----------
-- Keymaps
-----------

vim.g.mapleader = ","

vim.keymap.set("n",  "<leader><cr>", ":noh<cr>")
vim.keymap.set("n",  "<leader>ss", ":setlocal spell!<cr>")
vim.keymap.set("n",  "<leader>pp", ":setlocal paste!<cr>")
vim.keymap.set("n",  "<leader>cd", ":cd %:p:h<cr>:pwd<cr>")

vim.keymap.set("n", "<C-j>", "<C-W>j")
vim.keymap.set("n", "<C-k>", "<C-W>k")
vim.keymap.set("n", "<C-h>", "<C-W>h")
vim.keymap.set("n", "<C-l>", "<C-W>l")

-- Move by visual line
vim.keymap.set("", "j", "gj")
vim.keymap.set("", "k", "gk")

local telescope = require("telescope.builtin")
vim.keymap.set("n", "<c-f>",      telescope.find_files)
vim.keymap.set("n", "<c-b>",      telescope.buffers)
vim.keymap.set("n", "<leader>fg", telescope.live_grep)

local neotree = require('neo-tree.command')
vim.keymap.set('n', '<leader>nn', function() neotree.execute({ reveal = true, toggle = true }) end)
-- vim.keymap.set('n', '<leader>o',  function() neotree.execute({ source = 'buffers', toggle = true }) end)

-----------
-- Commands
-----------

vim.api.nvim_create_user_command("W", "w !sudo tee % > /dev/null", {})

-----------
-- Autocmds
-----------

-- Return to last edit position
vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        if mark[1] > 1 and mark[1] <= vim.api.nvim_buf_line_count(0) then
            vim.cmd('normal! g\'"')
        end
    end,
})

-- Toggle between last accessed tab
vim.g.lasttab = 1
vim.keymap.set("n", "<Leader>tl", function()
    vim.cmd("tabn " .. vim.g.lasttab)
end)
vim.api.nvim_create_autocmd("TabLeave", {
    callback = function() vim.g.lasttab = vim.fn.tabpagenr() end,
})

-----------------
-- Plugin config
-----------------

require("lualine").setup({
    options = {
        theme = "auto",
        globalstatus = true,
        icons_enabled = false,
    },
    tabline = {
        lualine_a = { { 'tabs', mode = 1, max_length = vim.o.columns } },
    },
    sections = {
        lualine_c = { { 'filename', path = 1 } },
    },
})

require("neo-tree").setup({
    window = { position = "float" },
    enable_git_status = false,
    default_component_configs = {
        icon = {
            folder_closed = "▶",
            folder_open   = "▼",
            folder_empty  = "",
            default       = "·",
        },
    },
})

local actions = require("telescope.actions")
require("telescope").setup({
    defaults = {
        file_ignore_patterns = { ".git/" },
        mappings = {
            i = {
                ["<esc>"] = actions.close,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
            },
        },
    },
})
