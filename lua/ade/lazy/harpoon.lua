return {
    "theprimeagen/harpoon",

    config = function()
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")


vim.keymap.set("n", "<leader>a", mark.add_file, { desc = "add curent file to harpoon list" })
vim.keymap.set("n", "<leader>ha", mark.add_file, { desc = "add curent file to [H]arpoon list" })
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)
vim.keymap.set("n", "<leader>hm", ui.toggle_quick_menu, { desc = "[H]arpoon quick menu"})
vim.keymap.set("n", "<S-Tab>", function() ui.nav_next();ui.toggle_quick_menu()  end, { desc = "toggle between harpoon  list" })

vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end)
vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end)
vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end)

    end
}
