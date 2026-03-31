-- Capture the default functions from nvim-lspconfig/lsp/rust_analyzer.lua before overriding it.
-- This file is in after/plugin to guarantee nvim-lspconfig has been initialised already.
local default_root_dir = vim.lsp.config['rust_analyzer'].root_dir
local default_before_init = vim.lsp.config['rust_analyzer'].before_init

vim.lsp.config('rust_analyzer', {
    cmd = { 'rust-analyzer' },
    filetypes = { 'rust' },
    -- To support rust_lang/rust, we need to detect when we're in the rust repo and use the git root
    -- instead of cargo project root.
    root_dir = function(bufnr, on_dir)
        local git_root = vim.fs.root(bufnr, { '.git' })
        if git_root then
            if vim.uv.fs_stat(vim.fs.joinpath(git_root, "src/etc/rust_analyzer_zed.json")) then
                on_dir(git_root)
                return
            end
        end
        -- For anything that doesn't match rust-lang/rust, fallback to default root_dir
        default_root_dir(bufnr, on_dir)
    end,
    before_init = function(init_params, config)
        -- When inside rust_lang/rust, we need to use the special rust_analyzer settings.
        local settings = vim.fs.joinpath(config.root_dir, "src/etc/rust_analyzer_zed.json")
        if vim.uv.fs_stat(settings) then
            local file = io.open(settings)
            local content = file:read("*a")
            file:close()
            -- vim.json.decode doesn't support JSONC so we need strip out comments.
            content = content:gsub("//[^\n]*", "")
            local json = vim.json.decode(content)
            config.settings["rust-analyzer"] = json.lsp["rust-analyzer"].initialization_options
        end
        default_before_init(init_params, config)
    end,
})

vim.lsp.enable('rust_analyzer')
