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

        map("n", "<C-l>", ":LLPStartPreview<CR>")
        map("n", "<CR>", ":AsyncRun rm -f out/*; latexmk -pdf -output-directory=out %<CR>")
    end
})

g.formatdef_latexindent = '"latexindent -c=/tmp -"'

-- coc-ltex 
g.coc_filetype_map = {['tex'] = 'latex'}
