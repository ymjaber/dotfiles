return {
    '3rd/image.nvim',
    config = function()
        require('image').setup({
            integrations = {
                markdown = {
                    enabled = true,
                    clear_in_insert_mode = true,
                    download_remote_images = true,
                    only_render_image_at_cursor = true,
                    only_render_image_at_cursor_mode = 'inline',
                    filetypes = { 'markdown', 'vimwiki' },
                    resolve_image_path = function(document_path, image_path, fallback)
                        return fallback(document_path, image_path)
                    end,
                },
                html = { enabled = false },
                css = { enabled = false },
            },

            -- Window behavior
            window_overlap_clear_enabled = true,     -- Clear images when windows overlap
            window_overlap_clear_ft_ignore = { 'cmp_menu', 'cmp_docs', '' },
            editor_only_render_when_focused = false, -- Always render images

            hijack_file_patterns = { '*.png', '*.jpg', '*.jpeg', '*.gif', '*.webp', '*.avif' },
        })
    end,
}
