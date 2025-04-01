return {
	'tpope/vim-fugitive',
	config = function()
		vim.keymap.set("n", "<leader>Gs",  vim.cmd.Git, { desc = "[G]it status"});
	end
}
