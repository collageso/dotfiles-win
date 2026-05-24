return {
	"stevearc/oil.nvim",
	dependencies = { { "echasnovski/mini.icons", opts = {} } },
	config = function()
		require("oil").setup({
			default_file_explorer = true,
			columns = { "icon" },
			skip_confirm_for_simple_edits = true,
			view_options = {
				show_hidden = true,
			},
			win_options = {
				wrap = true,
			},
		})

		vim.keymap.set("n", "<leader>ee", function()
			vim.cmd((vim.bo.filetype == "oil") and "bd" or "Oil")
		end, { desc = "Open current directory" })

		vim.keymap.set("n", "<leader>ef", function()
			vim.cmd((vim.bo.filetype == "oil") and "bd" or "Oil .")
		end, { desc = "Open root directory" })
	end,
}
