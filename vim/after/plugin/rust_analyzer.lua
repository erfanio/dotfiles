-- Capture the default functions from nvim-lspconfig/lsp/rust_analyzer.lua before overriding it.
-- This file is in after/plugin to guarantee nvim-lspconfig has been initialised already.
local default_root_dir = vim.lsp.config["rust_analyzer"].root_dir
local default_before_init = vim.lsp.config["rust_analyzer"].before_init

vim.lsp.config("rust_analyzer", {
    cmd = { "rust-analyzer" },
    filetypes = { "rust" },
    -- To support rust-lang/rust, we need to detect when we're in the rust repo and use the git root
    -- instead of cargo project root.
    root_dir = function(bufnr, on_dir)
        local git_root = vim.fs.root(bufnr, { ".git" })
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
        -- When inside rust-lang/rust, we need to use the special rust-analyzer settings.
        local settings = vim.fs.joinpath(config.root_dir, "src/etc/rust_analyzer_zed.json")
        if vim.uv.fs_stat(settings) then
            local file = io.open(settings)
            -- nvim 0.12+ supports comments otherwise you'll need content:gsub("//[^\n]*", "").
            local json = vim.json.decode(file:read("*a"), { skip_comments = true })
            file:close()
            config.settings["rust-analyzer"] = vim.tbl_deep_extend(
                "force", -- Overwrite with the special settings when there is a conflict.
                config.settings["rust-analyzer"] or {},
                json.lsp["rust-analyzer"].initialization_options
            )
        end
        default_before_init(init_params, config)
    end,
})

vim.lsp.enable("rust_analyzer")
