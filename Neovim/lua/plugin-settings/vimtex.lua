require("utils")

g.latex_view_general_viewer = 'zathura'
g.vimtex_compiler_latexmk = {['build_dir'] = "out"}
g.vimtex_compiler_method = 'latexmk'
-- g.vimtex_compiler_progname = '/usr/bin/nvr'
g.vimtex_view_general_options = '--unique file:@pdf#src:@line@tex'
g.vimtex_view_method = 'zathura'
