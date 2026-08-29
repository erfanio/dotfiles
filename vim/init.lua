-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ","

require("lazy").setup({
    -- Shared dependencies
    { "nvim-lua/plenary.nvim", lazy = true },
    { "nvim-tree/nvim-web-devicons", lazy = true },
    {
        "nvim-neo-tree/neo-tree.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("neo-tree").setup({
                window = { position = "float" },
                enable_git_status = false,
                filesystem = {
                    filtered_items = {
                        hide_dotfiles  = false,
                        hide_gitignored = true,
                    },
                },
            })

            local neotree = require("neo-tree.command")
            vim.keymap.set("n", "<leader>nn", function() neotree.execute({ reveal = true, toggle = true }) end)
            vim.keymap.set("n", "<leader>o",  function() neotree.execute({ source = "buffers", toggle = true }) end)
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
            "nvim-telescope/telescope-live-grep-args.nvim",
        },
        config = function()
            local actions = require("telescope.actions")
            require("telescope").setup({
                defaults = {
                    mappings = {
                        i = {
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-k>"] = actions.move_selection_previous,
                        },
                    },
                },
            })
            require("telescope").load_extension("fzf")
            require("telescope").load_extension("live_grep_args")

            local telescope = require("telescope.builtin")
            vim.keymap.set("n", "<C-f>",      telescope.find_files)
            vim.keymap.set("n", "<C-b>",      telescope.buffers)
            vim.keymap.set("n", "<leader>fg", require("telescope").extensions.live_grep_args.live_grep_args)

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    vim.keymap.set("n", "gd",         telescope.lsp_definitions,       { buffer = args.buf })
                    vim.keymap.set("n", "grr",        telescope.lsp_references,        { buffer = args.buf })
                    vim.keymap.set("n", "gri",        telescope.lsp_implementations,   { buffer = args.buf })
                    vim.keymap.set("n", "grt",        telescope.lsp_type_definitions,  { buffer = args.buf })
                    vim.keymap.set("n", "gO",         telescope.lsp_document_symbols,  { buffer = args.buf })
                    vim.keymap.set("n", "<leader>ws", telescope.lsp_workspace_symbols, { buffer = args.buf })
                    vim.keymap.set("n", "<leader>f",  vim.lsp.buf.format,              { buffer = args.buf })
                end,
            })
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        config = function()
            require("lualine").setup({
                options = {
                    theme        = "auto",
                    globalstatus = true,
                },
                tabline = {
                    lualine_a = { { "tabs", mode = 1, max_length = vim.o.columns } },
                },
                sections = {
                    lualine_c = { { "filename", path = 1 } },
                },
            })
        end,
    },
    "tpope/vim-abolish",
    "tpope/vim-surround",
    "tpope/vim-commentary",
    "tpope/vim-repeat",
    "christoomey/vim-tmux-navigator",
    "neovim/nvim-lspconfig",
    {
        "tomasr/molokai",
        priority = 1000,
        config = function()
            vim.cmd("color molokai")
        end,
    },
    {
        "dlyongemallo/diffview.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            local actions = require("diffview.actions")
            require("diffview").setup({
                default_args = {
                    DiffviewFileHistory = { "--no-merges", "--right-only", "--follow", "--max-count=10000" },
                },
                keymaps = {
                    file_history_panel = {
                        { "n", "<leader>do", actions.open_in_diffview, { desc = "Open the entry under the cursor in a diffview" } },
                    },
                },
            })

            vim.keymap.set('n', '<leader>dv', '<cmd>DiffviewToggle<cr>',                         { desc = 'Toggle Diffview' })
            vim.keymap.set('n', '<leader>do', '<cmd>DiffviewOpen<cr>',                           { desc = 'Diffview open' })
            vim.keymap.set('n', '<leader>dc', '<cmd>DiffviewClose<cr>',                          { desc = 'Diffview close' })
            vim.keymap.set('n', '<leader>dh', '<cmd>DiffviewFileHistory %<cr>',                  { desc = 'File history (current file)' })
            vim.keymap.set('n', '<leader>dH', '<cmd>DiffviewFileHistory<cr>',                    { desc = 'File history (repo)' })
            vim.keymap.set('v', '<leader>dh', "<Esc><cmd>'<,'>DiffviewFileHistory --follow<CR>", { desc = 'Range history' })
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
                on_attach = function(bufnr)
                    local gs = require("gitsigns")
                    vim.keymap.set("n", "<leader>hp", gs.preview_hunk_inline, { buffer = bufnr })
                    vim.keymap.set("n", "<leader>hs", gs.stage_hunk,          { buffer = bufnr })
                    vim.keymap.set("n", "<leader>hr", gs.reset_hunk,          { buffer = bufnr })
                    vim.keymap.set("n", "<leader>gb", gs.blame,               { buffer = bufnr })

                    vim.keymap.set("n", "]c", function() gs.nav_hunk("next", { target = "all" }) end, { buffer = bufnr })
                    vim.keymap.set("n", "[c", function() gs.nav_hunk("prev", { target = "all" }) end, { buffer = bufnr })
                end,
            })
        end,
    },
    { "nvim-mini/mini.nvim" },
})

-----------
-- Options
-----------

-- 4 space indent
vim.opt.shiftwidth = 4
vim.opt.expandtab  = true
-- Search
vim.opt.ignorecase = true
vim.opt.hlsearch   = true
vim.opt.incsearch  = true
vim.opt.magic      = true
-- Misc
vim.opt.undofile   = true
vim.opt.scrolloff  = 10
vim.opt.number     = true
vim.opt.mouse      = "a"
vim.opt.errorbells = false
vim.opt.visualbell = false
vim.opt.whichwrap:append("<,>,h,l,[,]")

-----------
-- Keymaps
-----------

vim.keymap.set("n", "<leader><cr>", ":noh<cr>")
vim.keymap.set("n", "<leader>ss",   ":setlocal spell!<cr>")
vim.keymap.set("n", "<leader>pp",   ":setlocal paste!<cr>")
vim.keymap.set("n", "<leader>cd",   ":cd %:p:h<cr>:pwd<cr>")

-- Move by visual line
vim.keymap.set("", "j", "gj")
vim.keymap.set("", "k", "gk")

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)

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

-- Dim inactive windows
local function dim_inactive()
  vim.api.nvim_set_hl(0, 'Normal',   { bg = 'NONE' })
  vim.api.nvim_set_hl(0, 'NormalNC', { bg = '#323232' })
end
dim_inactive()
vim.api.nvim_create_autocmd('ColorScheme', { callback = dim_inactive })
