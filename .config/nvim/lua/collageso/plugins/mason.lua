return {
    "mason-org/mason-lspconfig.nvim",
    opts = {
        automatic_enable = true
    },
    dependencies = {
        {
            "mason-org/mason.nvim",
            opts = {
                registries = {
                    "github:mason-org/mason-registry",
                    "github:crashdummyy/mason-registry",
                },
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                },
            }
        },
        {
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            opts = {
                ensure_installed = { "lua_ls", "clangd", "rust_analyzer", "hls", "ts_ls", "html", "cssls", "tailwindcss", "svelte", "eslint", "prettier" },
            }
        },
        "neovim/nvim-lspconfig",
    }
}
