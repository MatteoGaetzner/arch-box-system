return {
    -- add everforest
    "sainnhe/everforest",
    init = function()
        vim.opt.termguicolors = true
        vim.g.everforest_enable_italic = 1
        vim.g.everforest_transparent_background = 1
        vim.g.everforest_cursor = "auto"
        vim.g.everforest_ui_contrast = "high"
        vim.g.everforest_show_eob = 1
        vim.g.everforest_diagnostic_text_highlight = 1
        vim.g.everforest_diagnostic_line_highlight = 0
        vim.g.everforest_better_performance = 1
    end,

    -- Configure LazyVim to load gruvbox
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "everforest",
        },
    },
}
