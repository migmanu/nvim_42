return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "canary",
		dependencies = {
			{ "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
			{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
		},
		opts = {
			debug = true, -- Enable debugging
			-- See Configuration section for rest
			mappings = {
				complete = {
					detail = 'Use @<Tab> or /<Tab> for options.',
					insert = '<Tab>',
				},
				close = {
					normal = 'q',
					insert = '<C-c>'
				},
				reset = {
					normal = '',
					insert = ''
				},
				submit_prompt = {
					normal = '<CR>',
					insert = '<C-m>'
				},
				accept_diff = {
					normal = '<C-y>',
					insert = '<C-y>'
				},
				yank_diff = {
					normal = 'cgy',
				},
				show_diff = {
					normal = 'cgd'
				},
				show_system_prompt = {
					normal = 'cgp'
				},
				show_user_selection = {
					normal = 'cgs'
				},
			},
		},
		-- See Commands section for default commands if you want to lazy load on them
	},
}
