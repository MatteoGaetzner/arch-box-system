# sample ipython_config.py
c = get_config()

c.TerminalIPythonApp.display_banner = True
c.InteractiveShellApp.log_level = 20
c.InteractiveShellApp.exec_lines = [
    "from numpy import *",
    "import torch",
    "import math",
]

c.InteractiveShell.autoindent = True
c.InteractiveShell.colors = "Linux"
c.InteractiveShell.confirm_exit = False
c.InteractiveShell.editor = "vim"

c.PrefilterManager.multi_line_specials = True

c.AliasManager.user_aliases = [("la", "ls -al")]
