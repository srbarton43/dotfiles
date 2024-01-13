return {
	"tanvirtin/monokai.nvim", -- monokai themes
	priority = 1000,
	config = function()
		require('monokai').setup({
			palette = {
				base2 = '#121212', -- make bg darker
				green = '#86fa04', -- i like this green better
			},
		})
	end,
}
