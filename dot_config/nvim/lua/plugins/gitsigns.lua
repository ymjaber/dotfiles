-- plugins/gitsigns.lua
-- WHY: gutter signs + hunk stage/reset/preview + blame (lazygit via snacks is the full TUI).
return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		on_attach = function(buf)
			local gs = require("gitsigns")
			local function map(l, r, d)
				vim.keymap.set("n", l, r, { buffer = buf, desc = d })
			end
			map("]h", function()
				gs.nav_hunk("next")
			end, "next hunk")
			map("[h", function()
				gs.nav_hunk("prev")
			end, "prev hunk")
			map("<leader>hs", gs.stage_hunk, "stage hunk")
			map("<leader>hr", gs.reset_hunk, "reset hunk")
			map("<leader>hp", gs.preview_hunk, "preview hunk")
			map("<leader>hb", gs.blame_line, "blame line")
		end,
	},
}
