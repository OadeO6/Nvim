return {
    'augmentcode/augment.vim',
    config = function()
        vim.g.augment_disable_tab_mapping = true
        vim.g.augment_workspace_folders = {'/home/kali/Desktop/user-management' ,'/home/kali/Desktop/keploy'}
        vim.keymap.set("n", "<leader>ac", ":Augment chat<CR>", { desc = "[A]ugment [C]hat" })
        vim.keymap.set("i", "<C-Y>", "<cmd>call augment#Accept()<CR>", { desc = "Accept suggestion" })
        vim.keymap.set("n", "<leader>as", ":Augment status<CR>", { desc = "[A]ugment [S]tatus" })
        vim.keymap.set("n", "<leader>at", ":Augment chat-toggle<CR>", { desc = "[A]ugment [T]oggle chat pannel" })
        vim.keymap.set("n", "<leader>an", ":Augment chat-new<CR>", { desc = "[A]ugment [N]ew chat" })
        vim.keymap.set("n", "<leader>al", ":Augment log<CR>", { desc = "[A]ugment [L]og" })
    end
}
