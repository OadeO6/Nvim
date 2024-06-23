return {
    'VonHeikemen/lsp-zero.nvim',
    priority = 2000,
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
                { name = 'nvim_lua' },
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
        cmp.setup.cmdline(':', {
            sources = cmp.config.sources({
                { name = 'path' },
                    { name ='cmdline' }
                })
        })
        cmp.setup.cmdline('/', {
            sources = {
                { name = 'buffer' },
            }
        })
        for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/custom/snipets/*.lua", true)) do
            loadfile(ft_path)()
        end


        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
            callback = function(event)
                -- NOTE: Remember that Lua is a real programming language, and as such it is possible
                -- to define small helper and utility functions so you don't have to repeat yourself.
                --
                -- In this case, we create a function that lets us more easily define mappings specific
                -- for LSP related items. It sets the mode, buffer and description for us each time.
                local map = function(keys, func, desc, silent)
                    vim.keymap.set('n', keys, func, { silent = true , noremap = true, buffer = event.buf, desc = 'LSP: ' .. desc })
                end

                -- Jump to the definition of the word under your cursor.
                --  This is where a variable was first declared, or where a function is defined, etc.
                --  To jump back, press <C-t>.
                map(';gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

                -- Find references for the word under your cursor.
                map(';gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

                -- Jump to the implementation of the word under your cursor.
                --  Useful when your language has ways of declaring types without an actual implementation.
                map(';gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

                -- Jump to the type of the word under your cursor.
                --  Useful when you're not sure what type a variable is and you want to see
                --  the definition of its *type*, not where it was *defined*.
                -- map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

                -- Fuzzy find all the symbols in your current document.
                --  Symbols are things like variables, functions, types, etc.
                map(';ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

                -- Fuzzy find all the symbols in your current workspace.
                --  Similar to document symbols, except searches over your entire project.
                map(';ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

                -- Rename the variable under your cursor.
                --  Most Language Servers support renaming across files, etc.
                map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

                -- Execute a code action, usually your cursor needs to be on top of an error
                -- or a suggestion from your LSP for this to activate.
                map(';ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

                -- Opens a popup that displays documentation about the word under your cursor
                --  See `:help K` for why this keymap.
                map('K', vim.lsp.buf.hover, 'Hover Documentation')

                map(';gD', vim.lsp.buf.hover, '[G]oto [D]ocumentation and Hover Documentation')

                -- WARN: This is not Goto Definition, this is Goto Declaration.
                --  For example, in C this would take you to the header.
                map(';gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

                -- go to next dignistic
                map(';gn', function()vim.diagnostic.goto_next()end, '[G]oto [N]ext error')
                map(';gp', function()vim.diagnostic.goto_prev()end, '[G]oto [P]revious error')
                map('<leader>ln', function()vim.diagnostic.goto_next()end, '[G]oto [N]ext error')
                map('<leader>lp', function()vim.diagnostic.goto_prev()end, '[G]oto [P]revious error')

                -- The following two autocommands are used to highlight references of the
                -- word under your cursor when your cursor rests there for a little while.
                --    See `:help CursorHold` for information about when this is executed
                --
                -- When you move your cursor, the highlights will be cleared (the second autocommand).
                -- local client = vim.lsp.get_client_by_id(event.data.client_id)
                -- if client and client.server_capabilities.documentHighlightProvider then
                --     local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
                --     vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                --         buffer = event.buf,
                --         group = highlight_augroup,
                --         callback = vim.lsp.buf.document_highlight,
                --     })
                --
                --     vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                --         buffer = event.buf,
                --         group = highlight_augroup,
                --         callback = vim.lsp.buf.clear_references,
                --     })
                --
                --     vim.api.nvim_create_autocmd('LspDetach', {
                --         group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
                --         callback = function(event2)
                --             vim.lsp.buf.clear_references()
                --             vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
                --         end,
                --     })
                -- end

                -- The following autocommand is used to enable inlay hints in your
                -- code, if the language server you are using supports them
                --
                -- This may be unwanted, since they displace some of your code
                -- if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
                --    map('<leader>th', function()
                --        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
                --    end, '[T]oggle Inlay [H]ints')
                -- end
            end
        })






        lsp.setup()
    end,
}
