require("utils")

g.tex_flavor = "latex"

-- Or with a generic interface:
g.vimtex_view_general_viewer = 'okular'
g.vimtex_view_general_options = '--unique file:@pdf#src:@line@tex'

g.vimtex_compiler_method = 'latexmk'

-- vim-latex-live-preview
opt.updatetime = 1000
g.livepreview_engine = 'pdflatex'
g.livepreview_previewer = 'okular'
g.livepreview_texinputs = './out/'
g.livepreview_use_biber = 1

-- Quick compilation
local latex_augroup = vim.api.nvim_create_augroup('latex', {clear = true})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'tex',
  group = latex_augroup,
  callback = function()
        -- Hack to fix normal font colors (treesitter registers them as errors)
        vim.api.nvim_command(string.format("highlight Error ctermfg=%s guifg=%s", "223", "#d3c6aa"))

        --[[
            From: https://www.ejmastnak.com/tutorials/vim-latex/pdf-reader/#zathura
            Setup stuff for latex live preview using zathura
        --]] 
        
        -- Only set this variable once for the current Vim instance.
        if not g.vim_windows_id then 
            g.vim_window_id = fn.system("xdotool getactivewindow")
        end

        function TexFocusVim()
            cmd("sleep 200m")
            fn.system("xdotool windowfocus " .. g.vim_window_id)
            cmd("redraw")
        end

        -- Trigger refocus whenever VimtexView completes
        vim.api.nvim_create_autocmd('User', {
          pattern = 'VimtexEventView',
          group = latex_augroup,
          callback = TexFocusVim
        })

        vim.api.nvim_create_autocmd('InsertLeave', {
          pattern = '*.tex',
          group = latex_augroup,
          callback = function ()
            cmd.write({"%"})
          end
        })

        map("n", "<C-l>", ":LLPStartPreview<CR>")
        map("n", "<CR>", ":AsyncRun rm -f out/*; latexmk -pdf -output-directory=out %<CR>")
        map("n", "<leader>/", "<plug>(vimtex-view)")
        map("n", "<leader>ll", "<plug>(vimtex-compile)")
    end
})





g.formatdef_latexindent = '"latexindent -c=/tmp -"'

-- coc-ltex 
g.coc_filetype_map = {['tex'] = 'latex'}
