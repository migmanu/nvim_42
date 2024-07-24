-- Define the fuzzy find function
local function fuzzy_find_in_current_buffer()
	require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end

-- Define the workspace list function
local function list_workspace_folders()
	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end

require("which-key").add({
	-- Telescope keybindings
	{ "<leader>fg",      require("telescope.builtin").git_files,                     desc = "Search [G]it [F]iles" },
	{ "<leader>ff",      require("telescope.builtin").find_files,                    desc = "[S]earch [F]iles" },
	{ "<leader>fh",      require("telescope.builtin").help_tags,                     desc = "[S]earch [H]elp" },
	{ "<leader>fw",      require("telescope.builtin").grep_string,                   desc = "[S]earch current [W]ord" },
	{ "<leader>sg",      require("telescope.builtin").live_grep,                     desc = "[S]earch by [G]rep" },
	{ "<leader>sG",      ":LiveGrepGitRoot<cr>",                                     desc = "[S]earch by [G]rep on Git Root" },
	{ "<leader>sd",      require("telescope.builtin").diagnostics,                   desc = "[S]earch [D]iagnostics" },
	{ "<leader>sr",      require("telescope.builtin").resume,                        desc = "[S]earch [R]esume" },
	{ "<leader>?",       require("telescope.builtin").oldfiles,                      desc = "[?] Find recently opened files" },
	{ "<leader><space>", require("telescope.builtin").buffers,                       desc = "[ ] Find existing buffers" },
	{ "<leader>/",       fuzzy_find_in_current_buffer,                               desc = "Fuzzy find in current buffer with dropdown theme" },

	-- LSP keybindings
	{ "<leader>rn",      vim.lsp.buf.rename,                                         desc = "LSP: [R]e[n]ame" },
	{ "<leader>ca",      vim.lsp.buf.code_action,                                    desc = "LSP: [C]ode [A]ction" },
	{ "gd",              require("telescope.builtin").lsp_definitions,               desc = "LSP: [G]oto [D]efinition" },
	{ "gr",              require("telescope.builtin").lsp_references,                desc = "LSP: [G]oto [R]eferences" },
	{ "gI",              require("telescope.builtin").lsp_implementations,           desc = "LSP: [G]oto [I]mplementation" },
	{ "<leader>D",       require("telescope.builtin").lsp_type_definitions,          desc = "LSP: Type [D]efinition" },
	{ "<leader>ds",      require("telescope.builtin").lsp_document_symbols,          desc = "LSP: [D]ocument [S]ymbols" },
	{ "<leader>ws",      require("telescope.builtin").lsp_dynamic_workspace_symbols, desc = "LSP: [W]orkspace [S]ymbols" },
	{ "K",               vim.lsp.buf.hover,                                          desc = "LSP: Hover Documentation" },
	{ "<C-k>",           vim.lsp.buf.signature_help,                                 desc = "LSP: Signature Documentation" },
	{ "gD",              vim.lsp.buf.declaration,                                    desc = "LSP: [G]oto [D]eclaration" },
	{ "<leader>wa",      vim.lsp.buf.add_workspace_folder,                           desc = "LSP: [W]orkspace [A]dd Folder" },
	{ "<leader>wr",      vim.lsp.buf.remove_workspace_folder,                        desc = "LSP: [W]orkspace [R]emove Folder" },
	{ "<leader>wl",      list_workspace_folders,                                     desc = "LSP: [W]orkspace [L]ist Folders" },

	-- Other keybindings
	{ "<leader>e",       "<cmd>Ex<cr>",                                              desc = "Open Explorer" },
	{ "n",               "nzzzv",                                                    desc = "Center cursor in search" },
	{ "N",               "Nzzzv",                                                    desc = "Center cursor in search" },
	{ "<leader>r",       [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],     desc = "Replace current selected word" },
	{ "<C-h>",           ":wincmd h<CR>",                                            desc = "Move to left window" },
	{ "<C-j>",           ":wincmd j<CR>",                                            desc = "Move to bottom window" },
	{ "<C-k>",           ":wincmd k<CR>",                                            desc = "Move to top window" },
	{ "<C-l>",           ":wincmd l<CR>",                                            desc = "Move to right window" },
	{ "<leader>xx",      "<cmd>TroubleToggle<cr>",                                   desc = "Toggle Trouble" },
	{ "<leader>xq",      "<cmd>TroubleToggle quickfix<cr>",                          desc = "Toggle Quickfix" },
	{ "<leader>xr",      "<cmd>TroubleToggle lsp_references<cr>",                    desc = "Toggle LSP References" },
	{ "<A-i>",           '<CMD>lua require("FTerm").toggle()<CR>',                   mode = { 'n', 't' },                                      desc = "Toggle FTerm" },
})
