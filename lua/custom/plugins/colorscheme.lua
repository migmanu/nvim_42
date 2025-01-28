return {
	-- add theme
	{ "catppuccin/nvim" },
	{ "folke/tokyonight.nvim" },
	{ "nyoom-engineering/oxocarbon.nvim" },
	{ "Mofiqul/vscode.nvim" },
	{ "navarasu/onedark.nvim" },
	{ "miikanissi/modus-themes.nvim" },

	{
		-- Theme inspired by Atom
		"navarasu/onedark.nvim",
		priority = 1000,
		config = function()
			-- vim.opt.background = "light" -- set this to dark or light
			vim.cmd.colorscheme("onedark")
			-- vim.cmd("highlight MatchParen guifg=pink guibg=grey")
		end,
	},
}
