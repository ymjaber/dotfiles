-- plugins/diffview.lua
-- WHY: full-window diff + file history + merge-conflict resolution. dlyongemallo fork
-- (original abandoned ~2024; fork is de-facto maintainer).
return {
	"dlyongemallo/diffview-plus.nvim",
	cmd = { "DiffviewOpen", "DiffviewFileHistory" },
	opts = {},
	keys = {
		{ "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "diff view" },
		{ "<leader>gl", "<cmd>DiffviewFileHistory %<cr>", desc = "file history" },
	},
}
