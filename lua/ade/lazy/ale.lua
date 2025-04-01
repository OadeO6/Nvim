return {
    "dense-analysis/ale",
    config = function ()

        -- Enable ALE completion
        -- vim.g.ale_completion_enabled = 1
        -- vim.g.ale_completion_autoimport = 1
        --
        -- Set ALE to use the omnifunction for completion
        vim.cmd [[
  set omnifunc=ale#completion#Omnifunc
]]

        -- Configure ALE linters and fixers
        vim.g.ale_linters = {
            python = {'pycodestyle', 'snyk', 'mypy', 'flake8'},
            tf = {'tflint', 'snyk', 'terraform-ls'},
            go = {'gopls', 'golangci-lint'},
            -- javascript = {'eslint'},  -- for some reason eslint  is being ignored
            --lua = {'luacheck'}
        }

        vim.g.ale_fixers = {
            ['*'] = {'remove_trailing_lines', 'trim_whitespace'},
            python = {'autopep8', 'black', 'isort'},
            tf = {'tflint'},
            go = {'goimports', 'golines'},
            javascript = {'prettier'},
            --lua = {'luafmt'}
        }
        -- Enable verbose mode for ALE
        -- vim.g.ale_echo_msg_format = '[%linter%] %s [%severity%]'
        -- vim.g.ale_history_enabled = 1


        -- Use <C-x><C-o> for omnifunction completion
        vim.api.nvim_set_keymap('i', '<C-x><C-o>', '<C-x><C-o>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<leader>lf', ':ALEFix<CR>', { desc = "[L]int [F]ix", noremap = true, silent = true })

    end
}
