---------------  Convenience Variables  ----------------------------------------

g = vim.g
opt = vim.opt
cmd = vim.cmd
fn = vim.fn

---------------  Utils  --------------------------------------------------------

-- Checks whether path (file/directory) exists
function exists(path)
    if type(path)~="string" then return false end
    local file = io.open(path,"r")
    if (file ~= nil) then
        io.close(file)
        return true
    else
        return false
    end
end


-- Functional wrapper for mapping custom keybindings
function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Set data structure
function create_set(list)
    local set = {}
    for _, l in ipairs(list) do set[l] = true end
    return set
end
