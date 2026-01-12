return {
    'MeanderingProgrammer/render-markdown.nvim',
    enabled = true,
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
    },
    init = function()
        -- Custom checkbox checked color
        vim.cmd([[highlight RenderMarkdownCheckedCustom guifg=#ff7f7f gui=bold]])
    end,
    opts = {
        -- Heading configuration
        heading = {
            sign = true, -- Show signs in gutter
            icons = { '󰎤 ', '󰎧 ', '󰎪 ', '󰎭 ', '󰎱 ', '󰎳 ' }, -- Icons for each heading level
        },
        -- List bullet rendering
        bullet = {
            enabled = true,
        },
        -- Checkbox rendering
        checkbox = {
            enabled = true,
            position = 'inline', -- Inline with text
            unchecked = {
                icon = '   󰄱 ', -- Icon for unchecked
                highlight = 'RenderMarkdownUnchecked',
                scope_highlight = nil,
            },
            checked = {
                icon = '   󰱒 ', -- Icon for checked
                highlight = 'RenderMarkdownCheckedCustom',
                scope_highlight = nil,
            },
        },
    },
}
