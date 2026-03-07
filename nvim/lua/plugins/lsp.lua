return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        lazy = false,
        opts = {
            auto_install = true,
            -- Danh sách các server cần cài đặt tự động
            ensure_installed = { 
                "ts_ls",      -- JS/TS
                "pyright",    -- Python
                "clangd",     -- C/C++
                "lua_ls",     -- Lua
                "eslint",     -- Linter cho JS/TS
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        config = function()
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            -- Kết nối với nvim-cmp để có gợi ý code (autocompletion)
            if pcall(require, "cmp_nvim_lsp") then
                capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
            end

            -- Danh sách các server muốn kích hoạt
            local servers = {
                "ts_ls",
                "pyright",
                "clangd", -- C/C++
                "eslint",
                "lua_ls",
            }

            -- Cấu hình mặc định cho tất cả server trong danh sách
            for _, lsp in ipairs(servers) do
                local config = {
                    capabilities = capabilities,
                }

                -- Cấu hình riêng biệt cho Lua để nhận diện biến 'vim'
                if lsp == "lua_ls" then
                    config.settings = {
                        Lua = {
                            diagnostics = { globals = { "vim" } },
                            workspace = {
                                library = vim.api.nvim_get_runtime_file("", true),
                                checkThirdParty = false,
                            },
                            telemetry = { enable = false },
                        },
                    }
                end

                -- Áp dụng cấu hình và kích hoạt server
                vim.lsp.config[lsp] = config
                vim.lsp.enable(lsp)
            end

            --- Keymaps ---
            local opts = { noremap = true, silent = true }
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
            vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
            vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

            -- Tìm kiếm symbols (hàm, class...) bằng fzf-lua
            vim.keymap.set("n", "<leader>fm", function()
                local filetype = vim.bo.filetype
                local symbols_map = {
                    python = { "function", "class" },
                    javascript = { "function", "variable" },
                    typescript = { "function", "interface", "class" },
                    c = { "function", "struct" },
                    cpp = { "function", "class", "struct" },
                    lua = "function",
                }
                local symbols = symbols_map[filetype] or "function"
                require("fzf-lua").lsp_document_symbols({ symbols = symbols })
            end, opts)
        end,
    },
}
