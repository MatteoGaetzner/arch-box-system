# Fixing Vi Mode

As of 2022-08-14, ipython v8.4.0, vi mode in ipython is broken.
It can be fixed though, by commenting out some code and configuring some settings (see comment below).

# Comment

There are multiple related issues reported in this thread. I may have found the cause.

Summary: an Esc-related keybinding is making prompt_toolkit to wait for the next keystroke after an Esc keypress.

Details:
In vi/vim keymaps, there are two main timeout values: timeoutlen and ttimeoutlen (note the double t). timeoutlen is responsible for the timeout between keystrokes (e.g. for deleting till character 'a' dta); ttimeoutlen is responsible for distinguishing a lone Esc from a start of an escape sequence (n.b. VT100, ANSI escape sequence). These two parameters should be orthogonal. In ipython, the default setting is timeoutlen = 0.5 and ttimeoutlen = 0.01.

As people noted previously in the thread, reducing timeoutlen from 0.5 is actually making the Esc behavior faster. This should not happen. This work-around in turn makes dd and f<letter> not work properly as noted by multiple people in this thread. This suggests some tangling of the two parameters.

The culprint is `terminal/shortcuts.py`:

```python

 kb.add('escape', 'enter', filter=(has_focus(DEFAULT_BUFFER)
                         & ~has_selection
                         & insert_mode
                                   ))(reformat_and_execute)
 ```

So, you can comment out the above lines and your vi-mode should work fine. No need to mess with timeoutlen which in turn breaks normal vim commands.

As noted before, your config should have the following lines.

```python
c.TerminalInteractiveShell.editing_mode = 'vi'
c.TerminalInteractiveShell.emacs_bindings_in_vi_insert_mode = False
```

I will submit a pull request if people have no objections. I think it makes sense to tie the offending lines to ebivim condition in the source code like other Esc-initiated keybindings. reformat_and_execute does not do much on my setup anyway -- what is the correct behavior of this code?
