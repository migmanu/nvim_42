-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- 42 Stdheader
    use 'https://github.com/42Paris/42header'

    --telescope
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    -- theme
    use "olimorris/onedarkpro.nvim"
	use "ellisonleao/gruvbox.nvim"
	use "folke/tokyonight.nvim"
    --treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    -- harpoon
    use('https://github.com/ThePrimeagen/harpoon')

    --undotree
    use('https://github.com/mbbill/undotree')

    -- lualine
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    --nvm-web-icons
    use 'nvim-tree/nvim-web-devicons'

    --trouble [diagnosis]
    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("trouble").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    }

	--autopairs
    use {
        "windwp/nvim-autopairs",
        config = function()
			require("nvim-autopairs").setup {
			} 
		end
    }

    --lsp-colors
    use 'folke/lsp-colors.nvim'

    --todo-comments
    use {
  "folke/todo-comments.nvim",
  requires = "nvim-lua/plenary.nvim",
  config = function()
    require("todo-comments").setup {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  end
}



end)
