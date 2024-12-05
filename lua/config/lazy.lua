-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- [[ Install `lazy.nvim` plugin manager ]]
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- [[ Configure plugins ]]
-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.

require("lazy").setup({
	-- NOTE: First, some plugins that don't require any configuration

	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble"
	},

	-- Python and Django
	"tweekmonster/django-plus.vim",
	"HallerPatrick/py_lsp.nvim",

	-- FTerm
	"numToStr/FTerm.nvim",

	-- Git related plugins
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",

	-- 42 School related plugins
	-- 42 Header
	"42Paris/42header",

	-- 42 formatter
	-- {
	-- 	"cacharle/c_formatter_42.vim"
	-- },

	{
		-- better-escape
		"max397574/better-escape.nvim",
	},
	-- CopilotChat
	"CopilotC-Nvim/CopilotChat.nvim",

	-- GitHub Copilot
	{
		"zbirenbaum/copilot-cmp",
		config = function()
			require("copilot_cmp").setup()
		end
	},

	-- grug for searh and replace
	{
		'MagicDuck/grug-far.nvim',
		config = function()
			require('grug-far').setup({
			});
		end
	},


	-- NOTE: This is where your plugins related to LSP can be installed.
	--  The configuration is done below. Search for lspconfig to find it below.
	{
		-- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",

			-- Useful status updates for LSP
			-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
			{ "j-hui/fidget.nvim", opts = {} },

			-- Additional lua configuration, makes nvim stuff amazing!
			"folke/neodev.nvim",

		},
	},

	{
		-- Autocompletion
		"hrsh7th/nvim-cmp",
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",

			-- Adds LSP completion capabilities
			"hrsh7th/cmp-nvim-lsp",

			-- Adds a number of user-friendly snippets
			"rafamadriz/friendly-snippets",
		},
	},
	-- noice.nvim
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- add any options here
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			-- "rcarriga/nvim-notify",
		}
	},
	-- Useful plugin to show you pending keybinds.
	{ "folke/which-key.nvim",                opts = {} },
	{
		-- Adds git related signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		opts = {
			-- See `:help gitsigns.txt`
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			on_attach = function(bufnr)
				vim.keymap.set(
					"n",
					"<leader>hp",
					require("gitsigns").preview_hunk,
					{ buffer = bufnr, desc = "Preview git hunk" }
				)

				-- don't override the built-in and fugitive keymaps
				local gs = package.loaded.gitsigns
				vim.keymap.set({ "n", "v" }, "]c", function()
					if vim.wo.diff then
						return "]c"
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return "<Ignore>"
				end, { expr = true, buffer = bufnr, desc = "Jump to next hunk" })
				vim.keymap.set({ "n", "v" }, "[c", function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end, { expr = true, buffer = bufnr, desc = "Jump to previous hunk" })
			end,
		},
	},

	{
		-- Set lualine as statusline
		"nvim-lualine/lualine.nvim",
		-- See `:help lualine.txt`
		opts = {
			options = {
				icons_enabled = false,
				theme = "vscode",
				component_separators = "|",
				section_separators = "",
			},
		},
	},

	{
		-- prettier
		"prettier/vim-prettier",
	},

	-- Indent blankline by lukas-reineke
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },


	-- "gc" to comment visual regions/lines
	{ "numToStr/Comment.nvim",               opts = {} },

	-- Fuzzy Finder (files, lsp, etc)
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- Fuzzy Finder Algorithm which requires local dependencies to be built.
			-- Only load if `make` is available. Make sure you have the system
			-- requirements installed.
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				-- NOTE: If you are having trouble with this installation,
				--       refer to the README for telescope-fzf-native for more instructions.
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
		},
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function() vim.fn["mkdp#util#install"]() end,
	},

	{
		-- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		build = ":TSUpdate",
	},

	-- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
	--       These are some example plugins that I've included in the kickstart repository.
	--       Uncomment any of the lines below to enable them.
	-- require 'kickstart.plugins.autoformat',
	-- require 'kickstart.plugins.debug',

	-- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
	--    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
	--    up-to-date with whatever is in the kickstart repo.
	--    Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
	--
	--    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
	{ import = "custom.plugins" },
}, {})

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

--line numbers and relative numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- 4 space indenting
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false

vim.opt.smartindent = true

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- no line wraps
vim.opt.wrap = true

--improve undotree plugin acces to undos
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

--manage search highlighting and incremental search
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- gui colors
vim.opt.termguicolors = true

-- scrolling
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = "a"

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = "unnamedplus"

-- Enable break indent
vim.o.breakindent = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Disable compatibility with vi
vim.cmd('set nocompatible')

-- Enable filetype plugins
vim.cmd('filetype plugin on')

-- Enable syntax highlighting
vim.cmd('syntax on')

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

-- better-escape setup
require("better_escape").setup {
	timeout = vim.o.timeoutlen,
	default_mappings = true,
	mappings = {
		i = {
			j = {
				j = "<Esc>",
			},
		},
		c = {
			j = {
				j = "<Esc>",
			},
		},
		t = {
			j = {
				j = "<Esc>",
			},
		},
	},
}

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<C-u>"] = false,
				["<C-d>"] = false,
			},
		},
	},
})

-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")

-- Telescope live_grep in git root
-- Function to find the git root directory based on the current buffer's path
local function find_git_root()
	-- Use the current buffer's path as the starting point for the git search
	local current_file = vim.api.nvim_buf_get_name(0)
	local current_dir
	local cwd = vim.fn.getcwd()
	-- If the buffer is not associated with a file, return nil
	if current_file == "" then
		current_dir = cwd
	else
		-- Extract the directory from the current file's path
		current_dir = vim.fn.fnamemodify(current_file, ":h")
	end

	-- Find the Git root directory from the current file's path
	local git_root = vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")[1]
	if vim.v.shell_error ~= 0 then
		print("Not a git repository. Searching on current working directory")
		return cwd
	end
	return git_root
end

-- Custom live_grep function to search in git root
local function live_grep_git_root()
	local git_root = find_git_root()
	if git_root then
		require("telescope.builtin").live_grep({
			search_dirs = { git_root },
		})
	end
end

vim.api.nvim_create_user_command("LiveGrepGitRoot", live_grep_git_root, {})

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
-- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
vim.defer_fn(function()
	require("nvim-treesitter.configs").setup({
		-- Add languages to be installed here that you want installed for treesitter
		ensure_installed = {
			"c",
			"cpp",
			"lua",
			"python",
			"rust",
			"tsx",
			"javascript",
			"typescript",
			"vimdoc",
			"vim",
			"bash",
		},

		-- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
		auto_install = false,

		highlight = { enable = true },
		indent = { enable = true },
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<c-space>",
				node_incremental = "<c-space>",
				scope_incremental = "<c-s>",
				node_decremental = "<M-space>",
			},
		},
		textobjects = {
			select = {
				enable = true,
				lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
				keymaps = {
					-- You can use the capture groups defined in textobjects.scm
					["aa"] = "@parameter.outer",
					["ia"] = "@parameter.inner",
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["ac"] = "@class.outer",
					["ic"] = "@class.inner",
				},
			},
			move = {
				enable = true,
				set_jumps = true, -- whether to set jumps in the jumplist
				goto_next_start = {
					["]m"] = "@function.outer",
					["]]"] = "@class.outer",
				},
				goto_next_end = {
					["]M"] = "@function.outer",
					["]["] = "@class.outer",
				},
				goto_previous_start = {
					["[m"] = "@function.outer",
					["[["] = "@class.outer",
				},
				goto_previous_end = {
					["[M"] = "@function.outer",
					["[]"] = "@class.outer",
				},
			},
			swap = {
				enable = true,
				swap_next = {
					["<leader>a"] = "@parameter.inner",
				},
				swap_previous = {
					["<leader>A"] = "@parameter.inner",
				},
			},
		},
	})
end, 0)

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
	-- NOTE: Remember that lua is a real programming language, and as such it is possible
	-- to define small helper and utility functions so you don't have to repeat yourself
	-- many times.
	--
	-- In this case, we create a function that lets us more easily define mappings specific
	-- for LSP related items. It sets the mode, buffer and description for us each time.
	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end

		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end

	-- Create a command `:Format` local to the LSP buffer
	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		vim.lsp.buf.format()
	end, { desc = "Format current buffer with LSP" })
end

-- mason-lspconfig requires that these setup functions are called in this order
-- before setting up the servers.
require("mason").setup()
require("mason-lspconfig").setup()

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local servers = {
	clangd = {},
	-- gopls = {},
	-- pyright = {},
	html = { filetypes = { 'html', 'twig', 'hbs' } },

	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		},
	},
}

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
	ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = servers[server_name],
			filetypes = (servers[server_name] or {}).filetypes,
		})
	end,
})

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require("cmp")
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()
luasnip.config.setup({})

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	completion = {
		completeopt = "menu,menuone,noinsert",
	},
	mapping = cmp.mapping.preset.insert({
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete({}),
		["<C-y>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<C-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.locally_jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = {
		{ name = "copilot", group_index = 2 },
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	},
})

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
	{ "<leader>fg",      require("telescope.builtin").git_files,                       desc = "Search [G]it [F]iles" },
	{ "<leader>ff",      require("telescope.builtin").find_files,                      desc = "[S]earch [F]iles" },
	{ "<leader>fh",      require("telescope.builtin").help_tags,                       desc = "[S]earch [H]elp" },
	{ "<leader>fw",      require("telescope.builtin").grep_string,                     desc = "[S]earch current [W]ord" },
	{ "<leader>sg",      require("telescope.builtin").live_grep,                       desc = "[S]earch by [G]rep" },
	{ "<leader>sG",      ":LiveGrepGitRoot<cr>",                                       desc = "[S]earch by [G]rep on Git Root" },
	{ "<leader>sd",      require("telescope.builtin").diagnostics,                     desc = "[S]earch [D]iagnostics" },
	{ "<leader>sr",      require("telescope.builtin").resume,                          desc = "[S]earch [R]esume" },
	{ "<leader>?",       require("telescope.builtin").oldfiles,                        desc = "[?] Find recently opened files" },
	{ "<leader><space>", require("telescope.builtin").buffers,                         desc = "[ ] Find existing buffers" },
	{ "<leader>/",       fuzzy_find_in_current_buffer,                                 desc = "Fuzzy find in current buffer with dropdown theme" },

	-- LSP keybindings
	{ "<leader>rn",      vim.lsp.buf.rename,                                           desc = "LSP: [R]e[n]ame" },
	{ "<leader>ca",      vim.lsp.buf.code_action,                                      desc = "LSP: [C]ode [A]ction" },
	{ "gd",              require("telescope.builtin").lsp_definitions,                 desc = "LSP: [G]oto [D]efinition" },
	{ "gr",              require("telescope.builtin").lsp_references,                  desc = "LSP: [G]oto [R]eferences" },
	{ "gI",              require("telescope.builtin").lsp_implementations,             desc = "LSP: [G]oto [I]mplementation" },
	{ "<leader>D",       require("telescope.builtin").lsp_type_definitions,            desc = "LSP: Type [D]efinition" },
	{ "<leader>ds",      require("telescope.builtin").lsp_document_symbols,            desc = "LSP: [D]ocument [S]ymbols" },
	{ "<leader>ws",      require("telescope.builtin").lsp_dynamic_workspace_symbols,   desc = "LSP: [W]orkspace [S]ymbols" },
	{ "K",               vim.lsp.buf.hover,                                            desc = "LSP: Hover Documentation" },
	{ "<C-k>",           vim.lsp.buf.signature_help,                                   desc = "LSP: Signature Documentation" },
	{ "gD",              vim.lsp.buf.declaration,                                      desc = "LSP: [G]oto [D]eclaration" },
	{ "<leader>wa",      vim.lsp.buf.add_workspace_folder,                             desc = "LSP: [W]orkspace [A]dd Folder" },
	{ "<leader>wr",      vim.lsp.buf.remove_workspace_folder,                          desc = "LSP: [W]orkspace [R]emove Folder" },
	{ "<leader>wl",      list_workspace_folders,                                       desc = "LSP: [W]orkspace [L]ist Folders" },

	-- Other keybindings
	{ "<leader>e",       "<cmd>Ex<cr>",                                                desc = "Open Explorer" },
	{ "n",               "nzzzv",                                                      desc = "Center cursor in search" },
	{ "N",               "Nzzzv",                                                      desc = "Center cursor in search" },
	{ "<leader>r",       [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],       desc = "Replace current selected word" },
	{ "<C-h>",           ":wincmd h<CR>",                                              desc = "Move to left window" },
	{ "<C-j>",           ":wincmd j<CR>",                                              desc = "Move to bottom window" },
	{ "<C-k>",           ":wincmd k<CR>",                                              desc = "Move to top window" },
	{ "<C-l>",           ":wincmd l<CR>",                                              desc = "Move to right window" },
	{ "<leader>xx",      "<cmd>Trouble diagnostics toggle<cr>",                        desc = "Toggle Trouble" },
	{ "<leader>xq",      "<cmd>Trouble qflist toggle<cr>",                             desc = "Toggle Quickfix" },
	{ "<leader>xr",      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "Toggle LSP References" },
	{ "<A-i>",           '<CMD>lua require("FTerm").toggle()<CR>',                     mode = { 'n', 't' },                                      desc = "Toggle FTerm" },
})


-- these binds need to be here for them not to be overwritten

vim.keymap.set({ 'n', 'v' }, '<leader>st', require('stay-centered').toggle, { desc = 'Toggle stay-centered.nvim' })
-- move in insert mode with Control + h, j, k, l
vim.api.nvim_set_keymap('i', '<C-h>', '<left>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-j>', '<down>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-k>', '<up>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-l>', '<right>', { noremap = true })

-- move selected test in visual mode
vim.api.nvim_set_keymap('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true })
vim.api.nvim_set_keymap('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true })

-- Toggle spellcheck in English
vim.keymap.set('n', '<leader>sp', function()
	vim.opt_local.spell = not vim.opt_local.spell:get()
	vim.opt_local.spelllang = 'en_us'
	print("Spellcheck: " .. (vim.opt_local.spell:get() and "ON" or "OFF") .. " (Language: English)")
end, { desc = "Toggle Spellcheck (English)" })

-- Toggle spellcheck in Spanish
vim.keymap.set('n', '<leader>sps', function()
	vim.opt_local.spell = not vim.opt_local.spell:get()
	vim.opt_local.spelllang = 'es'
	print("Spellcheck: " .. (vim.opt_local.spell:get() and "ON" or "OFF") .. " (Language: Spanish)")
end, { desc = "Toggle Spellcheck (Spanish)" })
