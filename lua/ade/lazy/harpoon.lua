return {
    "theprimeagen/harpoon",

    config = function()
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>ha", mark.add_file, { desc = "[A]dd curent file to [H]arpoon list" })
vim.keymap.set("n", "<leader>hr", mark.rm_file, { desc = "[R]emove curent file from [H]arpoon list" })
vim.keymap.set("n", "<leader>hc", mark.clear_all, { desc = "[C]lear [H]arpoon list" })
vim.keymap.set("n", "<leader>1", ":1<CR><CR>", { desc = "jump to line 1"})
vim.keymap.set("n", "<leader>2", ":2<CR><CR>", { desc = "jump to line 2"})
vim.keymap.set("n", "<leader>3", ":3<CR><CR>", { desc = "jump to line 3"})
vim.keymap.set("n", "<leader>4", ":4<CR><CR>", { desc = "jump to line 4"})
vim.keymap.set("n", "<leader>5", ":5<CR><CR>", { desc = "jump to line 5"})
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)
vim.keymap.set("n", "<leader>hm", ui.toggle_quick_menu, { desc = "[H]arpoon quick menu"})
vim.keymap.set("n", "<S-Tab>", function() ui.nav_next();ui.toggle_quick_menu()end, { desc = "toggle between harpoon  list" })
-- vim.keymap.set("n", "<C-i>", ui.nav_toggle_quick_menu, { desc = "toggle between harpoon  list" })

vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end)
vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end)
vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end)

    end
}
