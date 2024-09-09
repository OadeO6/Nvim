return {
    { -- You can easily change to a different colorscheme.
        -- Change the name of the colorscheme plugin below, and then
        -- change the command in the config to whatever the name of that colorscheme is.
        --
        -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
        'folke/tokyonight.nvim',
        priority = 1000, -- Make sure to load this before all the other start plugins.
        init = function()
            local favorite_color = {
                'vscode',
                'rose-pine',
                'tokyonight-night',
            }
            local current_c = 1

            function SwichColors()
                current_c = current_c + 1
                if current_c > #favorite_color
                then
                    current_c = 1
                end
                vim.cmd('colorscheme ' .. favorite_color[current_c])
                print(favorite_color[current_c])
            end
            -- Load the colorscheme here.
            -- Like many other themes, this one has different styles, and you could load
            -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
            vim.cmd.colorscheme 'tokyonight-night'
            vim.keymap.set('n', ';uc', ':lua SwichColors()<CR>', { desc = "change color themes"})
            vim.keymap.set('n', '<leader>tc', ':lua SwichColors()<CR>', { desc = "[T]oggle color themes"})

            -- You can configure highlights by doing something like:
            vim.cmd.hi 'Comment gui=none'
        end,
    },
    {
        'rose-pine/neovim', as = 'rose-pine'
    },
    {
        'Mofiqul/vscode.nvim'
    }
}
