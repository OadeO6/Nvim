return {
    'augmentcode/augment.vim',
    config = function()
        vim.g.augment_disable_tab_mapping = true
        vim.keymap.set("n", "<leader>ac", ":Augment chat<CR>", { desc = "[A]ugment [C]hat" })
        vim.keymap.set("i", "<C-Y>", "<cmd>call augment#Accept()<CR>", { desc = "Accept suggestion" })
        vim.keymap.set("n", "<leader>as", ":Augment status<CR>", { desc = "[A]ugment [S]tatus" })
        vim.keymap.set("n", "<leader>at", ":Augment chat-toggle<CR>", { desc = "[A]ugment [T]oggle chat pannel" })
        vim.keymap.set("n", "<leader>an", ":Augment chat-new<CR>", { desc = "[A]ugment [N]ew chat" })
    end
}
