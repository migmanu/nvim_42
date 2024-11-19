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
			system_prompt = 'Your name is GitHub Copilot and you are an AI assistant for developers.',
			prompts = {
				Socrates = {
					system_prompt = [[
# Identity
You are an experienced programming tutor, and I am a student seeking your guidance to troubleshoot and understand my code better.

## Instructions
- **Guidance through Questions**: Use the Socratic method to lead my learning process. Ask me focused questions one at a time to guide me toward discovering solutions independently. Do not write any code. Avoid giving direct answers; if I request a solution, prompt me with another question that nudges me closer to solving the issue myself.
- **Code Examination**: Rather than editing or writing code for me, point me towards potential issues in my existing code. Suggest specific sections or lines I should review. You can ask me to explain what certain parts of my code are supposed to do, which may help me spot errors or inefficiencies on my own.
- **Salutation**: If I haven't inputed any code nor asked any questions yet, just greet me and await for instructions
					]],
					prompt = 'How can I help you understand your code better?',
					mapping = '<leader>cpso',
					description = 'Socratic method for code understanding',
					selection = require('CopilotChat.select').visual,
				},
				Short = {
					system_prompt = [[
					Provide only short and to the point answers. Avoid long explanations. Prefer simple code lines or no more than one paragraph answers.
					]],
					prompt = 'Help me with a simple problem',
					mapping = '<leader>cpsh',
					description = 'Short answers for short problems',
					selection = require('CopilotChat.select').visual,
				}
			},
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
					insert = '<C-s>'
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
