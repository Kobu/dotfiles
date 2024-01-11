return {
  n = {
    ["<leader>y"] = { cmd = '"+y', desc = "Yank to system clipboard" },
    ["<leader>Y"] = { cmd = '"+Y', desc = "Yank to system clipboard" },
    ["<Space>"] = { cmd = "<Nop>", desc = "Reserve space as leader keymap" },
    ["Q"] = { cmd = "<Nop>", desc = "Prevent me from having a bad time" },
    ["<C-_>"] = {
      cmd = function()
        require("Comment.api").toggle.linewise()
        vim.cmd("+1")
      end,
      desc = "Comment out currect line",
    },
    ["H"] = { cmd = ":BufferLineCyclePrev<CR>", desc = "Cycle to previous buffer" },
    ["L"] = { cmd = ":BufferLineCycleNext<CR>", desc = "Cycle to next buffer" },
    ["B"] = { cmd = ":Bdelete<CR>", desc = "Close current buffer" },
    ["sf"] = {
      cmd = function()
        vim.lsp.buf.format()
      end,
      desc = "Format according to null-ls",
    },
    ["ga"] = { cmd = ":Git blame<CR>", desc = "Run git blame" },
    ["gc"] = { cmd = ":Git commit<CR>", desc = "Commit" },
    ["gp"] = { cmd = ":Git push<CR>", desc = "Git push" },
    ["gas"] = { cmd = ":Git stash<CR>", desc = "Git stash all" },
    ["gap"] = { cmd = ":Git stash pop<CR>", desc = "Git stash pop" },
    ["git"] = { cmd = ":Git<CR>", desc = "Git" },
  },
  v = {
    ["K"] = { cmd = ":m '<-2<CR>gv=gv", desc = "Move highlighted text block up" },
    ["J"] = { cmd = ":m '>+1<CR>gv=gv", desc = "Move highlighted text block down" },
    ["<C-_>"] = {
      cmd = "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      desc = "Comment out highlighted text",
    },
    ["<leader>y"] = { cmd = '"+y', desc = "Yank to system clipboard" },
    ["gb"] = { cmd = ":Git blame<CR>", desc = "Run git blame" },
  },
  x = {
    ["p"] = { cmd = '"_dhp', desc = "Paste the current buffer, but dont override the clipboard" },
    ["<leader>p"] = { cmd = "p", desc = "Paste current buffer and override the clipboard" },
  },
}
