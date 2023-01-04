---------------  Load Plugins  -------------------------------------------------

require("plugins")

---------------  Utils ---------------------------------------------------------

require("utils")
require("self-written.linear-algebra")

--------------  University  ----------------------------------------------

require("university")

---------------  Builtin Settings  ---------------------------------------------

require("builtin-settings.basic-options")
require("builtin-settings.basic-keymaps")
require("builtin-settings.clipboard")
require("builtin-settings.line-numbers")
require("builtin-settings.spelling-checker")
require("builtin-settings.windows")
require("builtin-settings.text-objects")

--------------  Plugin Settings  ----------------------------------------------

require("plugin-settings.coc")
require("plugin-settings.lualine")
require("plugin-settings.treesitter")
require("plugin-settings.coc-explorer")
require("plugin-settings.ultisnips")
require("plugin-settings.git-gutter")
require("plugin-settings.gutentags")
require("plugin-settings.vimtex")

---------------  Themes  -------------------------------------------------------

require("themes")

--------------  Formating  ----------------------------------------------------

require("formatting")

--------------  Language Specific Things  -------------------------------------

require("programming-languages.bash")
require("programming-languages.c")
require("programming-languages.cpp")
require("programming-languages.docker")
require("programming-languages.i3")
require("programming-languages.latex")
require("programming-languages.markdown")
require("programming-languages.mutt")
require("programming-languages.python")

-------------------------------------------------------------------------------
