-- "Only required if you have packer configured as `opt`", whatever that means
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.8',
		-- or                            , branch = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

	use ({
		"rose-pine/neovim",
		as = "rose-pine",
		config = function()
			vim.cmd("colorscheme rose-pine")
		end,
	})

	use (
		'nvim-treesitter/nvim-treesitter',
		{run = ':TSUpdate'}
	)

	use {
		"ThePrimeagen/harpoon",
		requires = { {"nvim-lua/plenary.nvim"} }
	}

	use {
		"mbbill/undotree",
	}

	use {
		"tpope/vim-fugitive",
	}


	-- LSP Support
	use {
		'neovim/nvim-lspconfig',
	}
	use {
		'williamboman/mason.nvim',
	}
	use {
		'williamboman/mason-lspconfig.nvim',
	}

	-- Autocompletion
	use {
		'hrsh7th/nvim-cmp',
	}
	use {
		'hrsh7th/cmp-nvim-lsp',
	}
	use {
		'hrsh7th/cmp-buffer',
	}
	use {
		'hrsh7th/cmp-path',
	}
	use {
		'saadparwaiz1/cmp_luasnip',
	}
	use {
		'hrsh7th/cmp-nvim-lua',
	}

	-- Snippets
	use {
		'L3MON4D3/LuaSnip',
	}
	use {
		'rafamadriz/friendly-snippets',
	}
end)
