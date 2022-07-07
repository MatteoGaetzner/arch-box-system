from pdb import DefaultConfig


# pylint: disable-next=too-few-public-methods
class Config(DefaultConfig):
    """
    Config for the pdb++ python debugger.
    See: https://github.com/pdbpp/pdbpp?ref=morioh.com&utm_source=morioh.com#notes-on-color-options
    for configuration options.
    """

    encoding = "utf-8"
    highlight = True
    prompt = "pdb++: "
    sticky_by_default = True
    editor = "vim"
    # truncate_long_lines = True
