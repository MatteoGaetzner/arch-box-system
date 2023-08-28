return {
    "williamboman/mason.nvim",
    opts = {
        ensure_installed = {
            "stylua",
            "shfmt",
            "black",
            "rustfmt",
            "rust-analyzer",
        },
    },
}
