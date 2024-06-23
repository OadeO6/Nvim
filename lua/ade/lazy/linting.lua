-- using this only because javascript linters are
-- being ignoerd in ale for some reason
return {
    "mfussenegger/nvim-lint",
    event ={
        "BufReadPre",
        "BufNewFile",
    },
    config = function ()
        local lint = require("lint");

        require 'lspconfig'.eslint.setup {}
        -- require 'lspconfig'.pycodestyle.setup {}
        lint.linters_by_ft = {
            javascript = {"eslint"},
            javascriptreact = {"eslint"},
            typescript  = {"eslint"},
            typescriptreact  = {"eslint"},
            -- python = {"pycodestyle"}
        }

        local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
        vim.api.nvim_create_autocmd({"BufEnter", "BufWritePost", "InsertLeave"}, {
            group = lint_augroup,
            callback = function ()
                lint.try_lint()
            end
        })
        vim.keymap.set("n", "<leader>ll", function ()
            lint.try_lint()
        end, { desc = "activate [L]inting" })
    end
}
