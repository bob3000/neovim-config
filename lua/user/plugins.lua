local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  snapshot_path = vim.fn.stdpath("config") .. "/plugin",
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
  git = {
    clone_timeout = 300, -- Timeout, in seconds, for git clones
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use { "wbthomason/packer.nvim" } -- Have packer manage itself
  use { "nvim-lua/plenary.nvim" } -- Useful lua functions used by lots of plugins
  use { "windwp/nvim-autopairs" } -- Autopairs, integrates with both cmp and treesitter
  use { "numToStr/Comment.nvim" }
  use { "JoosepAlviste/nvim-ts-context-commentstring" }
  use { "kyazdani42/nvim-web-devicons" }
  use { "kyazdani42/nvim-tree.lua" }
  use { "akinsho/bufferline.nvim" }
  use { "moll/vim-bbye" }
  use { "nvim-lualine/lualine.nvim" }
  use { "akinsho/toggleterm.nvim" }
  use { "ahmedkhalf/project.nvim" }
  use { "lewis6991/impatient.nvim" }
  use { "lukas-reineke/indent-blankline.nvim" }
  use { "goolord/alpha-nvim" }
  use { "LunarVim/bigfile.nvim" }

  -- Colorschemes
  use { "folke/tokyonight.nvim" }
  use { "lunarvim/darkplus.nvim" }
	use { "sainnhe/gruvbox-material" }
  use "olimorris/onedarkpro.nvim"

  -- cmp plugins
  use { "hrsh7th/nvim-cmp" } -- The completion plugin
  use { "hrsh7th/cmp-buffer" } -- buffer completions
  use { "hrsh7th/cmp-path" } -- path completions
  use { "saadparwaiz1/cmp_luasnip" } -- snippet completions
  use { "hrsh7th/cmp-nvim-lsp" }
  use { "hrsh7th/cmp-nvim-lua" }
	use { "hrsh7th/cmp-emoji" }
	use { "hrsh7th/cmp-cmdline" }

  -- snippets
  use { "L3MON4D3/LuaSnip" } --snippet engine
  use { "rafamadriz/friendly-snippets" } -- a bunch of snippets to use

  -- LSP
  -- use { "williamboman/nvim-lsp-installer" } -- simple to use language server installer
  use { "neovim/nvim-lspconfig" } -- enable LSP
  use { "williamboman/mason.nvim" }
  use { "williamboman/mason-lspconfig.nvim" }
  use { "jose-elias-alvarez/null-ls.nvim" } -- for formatters and linters
  use { "RRethy/vim-illuminate" }
  use { "b0o/schemastore.nvim"}

  -- Telescope
  use { "nvim-telescope/telescope.nvim" }
  use { "nvim-telescope/telescope-media-files.nvim" }

  -- Treesitter
  use { "nvim-treesitter/nvim-treesitter" }

  -- Git
  use { "lewis6991/gitsigns.nvim" }

  -- DAP
  use { "mfussenegger/nvim-dap" }
  use { "rcarriga/nvim-dap-ui" }
  use { "ravenxrz/DAPInstall.nvim" }

	-- markdown
	use { "mzlogin/vim-markdown-toc" }
	use { "jakewvincent/mkdnflow.nvim",
    rocks = "luautf8",
    config = function()
        require("mkdnflow").setup({})
    end
  }
	use { "toppair/peek.nvim", run = "deno task --quiet build:fast", }

  -- rust
  use { "simrat39/rust-tools.nvim" }
	use {
		"Saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		requires = { { "nvim-lua/plenary.nvim" } },
		config = function()
			require("crates").setup()
		end,
	}

	-- spelling
	use {
		"psliwka/vim-dirtytalk",
		run = ":DirtytalkUpdate",
	}
	-- syntax
	use { "chr4/nginx.vim" }
	use { "Glench/Vim-Jinja2-Syntax" }
  use { "p00f/nvim-ts-rainbow" }

	-- editing
	use { "tpope/vim-surround" }
	use { "tpope/vim-repeat" }
	use { "bronson/vim-trailing-whitespace" }
	use { "andymass/vim-matchup" }
  use { "farmergreg/vim-lastplace" }
	use {
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end
	}
	use {
		"danymat/neogen",
		config = function() require("neogen").setup({}) end,
		requires = "nvim-treesitter/nvim-treesitter",
	}
  use({
    "Pocco81/auto-save.nvim",
    config = function() require("auto-save").setup({}) end,
  })

	-- search / replace
	use {
		"nvim-telescope/telescope-live-grep-args.nvim",
		config = function()
			require("telescope").load_extension("live_grep_args")
		end
	}
	use {
		"windwp/nvim-spectre",
		config = function()
			require("spectre").setup()
		end
	}

  -- ui
	use {
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end
	}
  use {
    "declancm/cinnamon.nvim",
    config = function() require("cinnamon").setup() end
  }
  use { "folke/which-key.nvim" }
  use { "folke/trouble.nvim", requires = "kyazdani42/nvim-web-devicons" }
  use { "folke/todo-comments.nvim", requires = "nvim-lua/plenary.nvim" }
  use { "gelguy/wilder.nvim" }
  use {
    "simrat39/symbols-outline.nvim",
    config = function() require("symbols-outline").setup() end
  }
  use {
      "SmiteshP/nvim-navic",
      requires = "neovim/nvim-lspconfig"
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
