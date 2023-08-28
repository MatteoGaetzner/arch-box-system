return {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function()
        -- debug = true
        local nls = require("null-ls")
        return {
            root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
            sources = {
                nls.builtins.formatting.fish_indent,
                nls.builtins.diagnostics.fish,
                nls.builtins.formatting.stylua,
                nls.builtins.formatting.black,
                nls.builtins.formatting.isort,
                nls.builtins.formatting.shfmt,
                nls.builtins.formatting.bibclean,
                nls.builtins.formatting.rustfmt,
            },
        }
    end,
}
