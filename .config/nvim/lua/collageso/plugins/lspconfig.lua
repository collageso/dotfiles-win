return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        {
            "folke/lazydev.nvim",
            ft = "lua",
            opts = {
                library = {
                    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                },
                servers = {
                    copilot = { enabeld = false },
                }
            },
        },
    },
    config = function()
        local lspconfig = require("lspconfig")
        local keymap = vim.keymap

        -- Global diagnostic sign configuration
        local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        -- LSP Attach autocmd for keymaps and buffer-local settings
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                local bufnr = ev.buf
                local client = vim.lsp.get_client_by_id(ev.data.client_id)

                -- Prevent errors if client is nil
                if not client then return end

                local opts = { buffer = bufnr, silent = true }

                -- Navigation and Information Keybindings
                opts.desc = "Show LSP references"
                keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

                opts.desc = "Go to declaration"
                keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

                opts.desc = "Show LSP definitions"
                keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

                opts.desc = "Show LSP implementations"
                keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

                opts.desc = "Show LSP type definitions"
                keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

                opts.desc = "See available code actions"
                keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

                opts.desc = "Smart rename"
                keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

                opts.desc = "Show buffer diagnostics"
                keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

                opts.desc = "Show line diagnostics"
                keymap.set("n", "<leader>dl", vim.diagnostic.open_float, opts)

                opts.desc = "Show documentation"
                keymap.set("n", "K", vim.lsp.buf.hover, opts)

                opts.desc = "Restart LSP"
                keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)

                -- Enable Inlay Hints if supported by the server
                if client.server_capabilities.inlayHintProvider then
                    vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
                end

                -- Generic Auto-format on save for all supported languages
                if client.server_capabilities.documentFormattingProvider then
                    local format_group = vim.api.nvim_create_augroup("LspFormatting-" .. bufnr, { clear = true })
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = format_group,
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format({ bufnr = bufnr, id = client.id })
                        end,
                    })
                end
            end,
        })

        -- nvim-cmp integration capabilities
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        ------------------------------------------------------------
        -- LSP Server Configurations (Native API)
        ------------------------------------------------------------

        -- Lua configuration
        vim.lsp.config("lua_ls", {
            capabilities = capabilities,
            settings = {
                Lua = {
                    runtime = { version = 'LuaJIT' },
                    diagnostics = { globals = { 'vim' } },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true),
                        checkThirdParty = false,
                    },
                    telemetry = { enable = false },
                },
            },
        })

        -- C/C++ configuration
        vim.lsp.config("clangd", {
            capabilities = capabilities,
            cmd = { "clangd", "--background-index", "--clang-tidy" },
        })

        -- Haskell configuration
        vim.lsp.config("hls", {
            capabilities = capabilities,
            filetypes = { 'haskell', 'lhaskell', 'literatehaskell' },
            root_markers = { 'stack.yaml', 'cabal.project', 'package.yaml', 'hie.yaml', '.git' },
            settings = {
                haskell = { formattingProvider = "ormolu" }
            }
        })

        -- Rust configuration
        vim.lsp.config("rust_analyzer", {
            capabilities = capabilities,
            settings = {
                ["rust-analyzer"] = {
                    cargo = { features = "all" },
                    checkOnSave = { command = "clippy" },
                    diagnostics = { enable = true },
                },
            }
        })
    end,
}
