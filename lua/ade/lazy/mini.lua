return {
  { 'onsails/lspkind-nvim' },
  -- Highlight todo, notes, etc in comments
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false }
  },
  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },
  {                     -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
      require('which-key').setup()

      -- Document existing key chains
      require('which-key').register {
        ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
        [';d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
        ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
        ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
        [';'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
        ['<leader>t'] = { name = '[T]oggle', _ = 'which_key_ignore' },
        ['<leader>h'] = { name = '[H]arpoon', _ = 'which_key_ignore' },
        ['<leader>l'] = { name = '[L]int', _ = 'which_key_ignore' },
        [';u'] = { name = '[U]i', _ = 'which_key_ignore' },
        [';c'] = { name = '[C]ode', _ = 'which_key_ignore' },
        [';s'] = { name = '[S]ubstitution', _ = 'which_key_ignore' },
        ['<leader>g'] = { name = '[G]oto', _ = 'which_key_ignore' },
        ['<leader>v'] = { name = '[V]ariable/Symbol', _ = 'which_key_ignore' },
        [';G'] = { name = '[G]it', _ = 'which_key_ignore' },
        ['<leader>G'] = { name = '[G]it', _ = 'which_key_ignore' },
        [';g'] = { name = '[G]oto', _ = 'which_key_ignore' },
        [']'] = { name = 'goto Next ] ...', _ = 'which_key_ignore' },
        ['['] = { name = 'goto Previous [ ...', _ = 'which_key_ignore' },
      }
      -- visual mode
      require('which-key').register({
        ['<leader>h'] = { 'Git [H]unk' },
      }, { mode = 'v' })
    end,
  },
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {},
  },
}
