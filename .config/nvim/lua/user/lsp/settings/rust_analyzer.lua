return {
  settings = {
    ["rust-analyzer"] = {
      check = {
        command = "clippy",
      },
      diagnostics = {
        enable = true,
        experimental = {
          enable = true,
        },
      },
    },
  },
}
