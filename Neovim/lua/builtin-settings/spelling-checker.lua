require("utils")

-- Show nine spell checking candidates at most
opt.spellsuggest = "best,9"

switch_spell_lang = coroutine.create(
    function ()
        -- spellcheck languages to loop over
        local lang_list = {"en_us", "de_de", "none"}

        -- loop through languages
        local lang_ndx = 1
        while true do
            if lang_ndx == 3 then
                opt.spell = false
            else
                opt.spell = true
                opt.spelllang = lang_list[lang_ndx]
            end
            print(string.format("Language: %s", lang_list[lang_ndx]))
            coroutine.yield(lang_ndx)
            lang_ndx = (lang_ndx % 3) + 1
        end
    end
)

vim.keymap.set("i","<F12>", 
    function()
        coroutine.resume(switch_spell_lang)
    end, 
    {desc = "Spelling language switcher"}
)

vim.keymap.set("n","<F12>", 
    function()
        coroutine.resume(switch_spell_lang)
    end, 
    {desc = "Spelling language switcher"}
)
