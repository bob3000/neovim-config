local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/code_actions
local code_actions = null_ls.builtins.code_actions

-- https://github.com/prettier-solidity/prettier-plugin-solidity
null_ls.setup({
	debug = false,
	sources = {
		code_actions.cspell.with({
			filetypes = { "gitcommit" },
		}),
		code_actions.gitsigns,
		diagnostics.codespell,
		diagnostics.cspell.with({
			filetypes = { "gitcommit" },
		}),
		diagnostics.flake8,
		formatting.prettier.with({
			extra_filetypes = { "toml" },
		}),
		formatting.black.with({ extra_args = { "--fast" } }),
		formatting.codespell.with({
			extra_args = { "--skip", "*.latex,*.md" },
		}),
		formatting.isort,
		formatting.stylua,
		formatting.npm_groovy_lint,
		formatting.shfmt,
	},
})
