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
    ["<leader>e"] = { cmd = ":NvimTreeToggle<CR>", desc = "Toggle NvimTree window" },
    ["<C-n>"] = { cmd = ":NvimTreeFocus<CR>", desc = "Focus NvimTree window" },
    ["H"] = { cmd = ":BufferLineCyclePrev<CR>", desc = "Cycle to previous buffer" },
    ["L"] = { cmd = ":BufferLineCycleNext<CR>", desc = "Cycle to next buffer" },
    ["B"] = { cmd = ":Bdelete<CR>", desc = "Close current buffer" },
    ["gf"] = {
      cmd = function()
        vim.lsp.buf.format()
      end,
      desc = "Format according to null-ls",
    },
    ["gb"] = { cmd = ":Git blame<CR>", desc = "Run git blame" },
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
    ["p"] = { cmd = '"_dp', desc = "Paste the current buffer, but dont override the clipboard" },
    ["<leader>p"] = { cmd = "p", desc = "Paste current buffer and override the clipboard" },
  },
}
