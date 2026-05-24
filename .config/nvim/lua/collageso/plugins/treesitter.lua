return {
    "nvim-treesitter/nvim-treesitter",
    version = "v0.9.3",
    event = { "BufReadPre", "BufNewFile" },
    lazy = false,
    build = ":TSUpdate",
    config = function()
        -- import nvim-treesitter plugin
        local treesitter = require("nvim-treesitter.configs")

        -- configure treesitter
        treesitter.setup({ -- enable syntax highlighting
            highlight = {
                enable = true,
            },
            -- enable indentation
            indent = { enable = true },
            -- ensure these language parsers are installed
            ensure_installed = {
                "bash",
                "css",
                "json",
                "go",
                "rust",
                "c",
                "cpp",
                "cmake",
                "java",
                "javascript",
                "typescript",
                "tsx",
                "yaml",
                "xml",
                "html",
                "markdown",
                "markdown_inline",
                "regex",
                "svelte",
                "graphql",
                "lua",
                "haskell",
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                },
            },
        })
    end,
}
