return {
	'tpope/vim-fugitive',
	config = function()
		vim.keymap.set("n", ";Gs>",  vim.cmd.Git);
	end
}
