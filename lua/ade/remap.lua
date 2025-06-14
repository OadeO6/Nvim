vim.g.mapleader = " "
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Custom mapper for file and folder creation
-- create file in current file directory
vim.keymap.set("n", "<leader>nf", ":vi %:h", { desc = "Create [n]ew [F]ile in current file directory" })
vim.keymap.set("n", "<leader>nF", ":vi ", { desc = "Create [n]ew [F]ile in the root directory" })
-- create folder in current file directory
vim.keymap.set("n", "<leader>nd", "::!mkdir %:h", { desc = "Create [n]ew [D]irectory in current file directory" })
vim.keymap.set("n", "<leader>nD", ":!mkdir ", { desc = "Create [n]ew [D]irectory in the root directory" })
-- toggle treesiter-context
vim.keymap.set("n", "<leader>tT", ':lua require("treesitter-context").toggle()<CR>', { desc = "[T]oggle [T]reesiter-context sticky func" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>tv", function()
    require("vim-with-me").StartVimWithMe()
end, { desc = "Start VimWithMe" })
vim.keymap.set("n", "<leader>tV", function()
    require("vim-with-me").StopVimWithMe()
end, { desc = "Stop VimWithMe" })

-- Dadbod(dadbod)  my database manager
vim.keymap.set("n", "<leader>D", ":DBUIToggle<CR>", { desc = "[D]adbod Toggle" })

-- temporary marking
vim.keymap.set("n", "<leader>'", "m'", { desc = "Mark this location with [']" })

-- greatest remap ever
vim.keymap.set("n", "<leader>p", [["_ddP]], { desc = "[D]elete line and [P]aste" })

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "[Y]ank into system main buffer" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "[Y]ank into system main buffer" })

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "[D] delete into void"})
vim.keymap.set( {"v", "x"},  "<leader>p", [["_dp]], { desc = "[D]elete in virtual mode and [P]aste" })

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- substitution
vim.keymap.set("n", ";se", [[:%s///<Left><Left>]], { desc = "[S] substitution empty"} )
vim.keymap.set("n", ";ss", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "[S] substitution all ocurence"} )
vim.keymap.set("n", ";sc", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gIc<Left><Left><Left><Left>]], { desc = "[S] substitution all ocurence with confirmation"} )
vim.keymap.set("n", ";sl", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/I<Left><Left><Left>]], { desc = "[S] substitution oncurent line"} )
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make the curent file an exicutable"})

vim.keymap.set(
    "n",
    "<leader>ee",
    "oif err != nil {<CR>}<Esc>Oreturn err<Esc>"
)

vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.dotfiles/nvim/.config/nvim/lua/ade/packer.lua<CR>");
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)


vim.keymap.set("n", "<C-o>", "o<Esc>")



-- =================== extra ================ --
-- vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
--
-- -- Diagnostic keymaps
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
--
-- -- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- -- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- -- is not what someone will guess without a bit more experience.
-- --
-- -- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- -- or just use <C-\><C-n> to exit terminal mode
-- vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
--
-- -- TIP: Disable arrow keys in normal mode
-- -- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- -- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- -- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- -- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')
--
-- -- Keybinds to make split navigation easier.
-- --  Use CTRL+<hjkl> to switch between windows
-- --
-- --  See `:help wincmd` for a list of all window commands
-- vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
-- vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
-- vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
-- vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
--
