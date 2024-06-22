return {
    'VonHeikemen/lsp-zero.nvim',
    dependencies = {
        { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
        'williamboman/mason-lspconfig.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim',

        {
            "windwp/nvim-autopairs",
            config = function() require("nvim-autopairs").setup {} end
        },
        { 'neovim/nvim-lspconfig' },
        -- Autocompletion
        { 'hrsh7th/nvim-cmp' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-path' },
        {
            'L3MON4D3/LuaSnip',
            build = (function()
                -- Build Step is needed for regex support in snippets.
                -- This step is not supported in many windows environments.
                -- Remove the below condition to re-enable on windows.
                if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
                    return
                end
                return 'make install_jsregexp'
            end)(),
            dependencies = {
                -- `friendly-snippets` contains a variety of premade snippets.
                --    See the README about individual language/framework/plugin snippets:
                --    https://github.com/rafamadriz/friendly-snippets
                {
                  'rafamadriz/friendly-snippets',
                  config = function()
                    require('luasnip.loaders.from_vscode').lazy_load()
                  end,
                },
            },
        },
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-nvim-lsp-signature-help',
    },
    config = function()
        local lsp = require("lsp-zero")

        require 'lspconfig'.tailwindcss.setup {}
        require 'lspconfig'.tsserver.setup {}
        require 'lspconfig'.html.setup {}
        require 'lspconfig'.eslint.setup {}
        require 'lspconfig'.dockerls.setup {}
        require 'lspconfig'.docker_compose_language_service.setup {}
        require 'lspconfig'.pyright.setup {}
        require 'lspconfig'.htmx.setup {}
        require 'lspconfig'.lua_ls.setup {}


        lsp.preset('recommended')

        lsp.on_attach(function(client, bufnr)
            lsp.default_keymaps({ buffer = bufnr })
        end)

        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        local cmp = require('cmp')
        local cmp_action = require('lsp-zero').cmp_action()
        local luasnip = require("luasnip")
        luasnip.config.setup {}

        cmp.event:on(
            'confirm_done',
            cmp_autopairs.on_confirm_done()
        )

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            completion = { completeopt = 'menu,menuone,noinsert' },

            mapping = cmp.mapping.preset.insert({

                -- ["<Tab>"] = cmp.mapping(function(fallback)
                --     -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
                --     if cmp.visible() then
                --         local entry = cmp.get_selected_entry()
                --         if not entry then
                --             cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                --         else
                --             cmp.confirm()
                --         end
                --     else
                --         fallback()
                --     end
                -- end, { "i", "s", "c", }),
                -- ['<C-Space>'] = cmp.mapping.complete(),
                -- Select the [n]ext item
                ['<C-n>'] = cmp.mapping.select_next_item(),
                -- Select the [p]revious item
                ['<C-p>'] = cmp.mapping.select_prev_item(),

                -- Scroll the documentation window [b]ack / [f]orward
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),

                -- Accept ([y]es) the completion.
                --  This will auto-import if your LSP supports it.
                --  This will expand snippets if the LSP sent a snippet.
                ['<C-y>'] = cmp.mapping.confirm { select = true },

                -- Navigate between snippet placeholder
                -- ['<C-f>'] = cmp_action.luasnip_jump_forward(),
                -- ['<C-b>'] = cmp_action.luasnip_jump_backward(),

                -- Scroll up and down in the completion documentation
                -- ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                -- ['<C-d>'] = cmp.mapping.scroll_docs(4),
                -- --- or
                -- <c-l> will move you to the right of each of the expansion locations.
                -- <c-h> is similar, except moving you backwards.

                ['<C-l>'] = cmp.mapping(function()
                    if luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    end
                end, { 'i', 's' }),
                ['<C-h>'] = cmp.mapping(function()
                    if luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    end
                end, { 'i', 's' }),
            }),
            sources = {
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = 'buffer' },
                { name = 'nvim_lsp_signature_help' },
            },
            formatting = {
                format = function(entry, vim_item)
                    vim_item.menu = ({
                        nvim_lsp = "[LSP]",
                        spell = "[Spell]",
                        buffer = "[Buffer]",
                        path = "[Path]",
                        nvim_lsp_signature_help = "[Signature]",
                        treesitter = "[Treesiter]",
                    })[entry.source.name]
                    -- vim_item.kind = string.format("icon %s",  vim_item.kind)

                    return vim_item
                end
            }
        })
        lsp.setup()
        for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/custom/snipets/*.lua", true)) do
            loadfile(ft_path)()
        end
    end,
}
