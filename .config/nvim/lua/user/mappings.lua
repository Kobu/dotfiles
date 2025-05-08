return {
  n = {
    ["<leader>y"] = { cmd = '"+y', desc = "Yank to system clipboard" },
    ["<C-q>"] = { cmd = ":q<CR>", desc = "Remap :q" },
    ["<leader>Y"] = { cmd = '"+Y', desc = "Yank to system clipboard" },
    ["Y"] = { cmd = "y$", desc = "Yank rest of the line" },
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
    ["B"] = { cmd = require("bufdelete").bufdelete, desc = "Close current buffer" },
    ["sf"] = {
      cmd = function()
        local ft = vim.bo.filetype
        if ft == "typescript" or ft == "typescriptreact" then
          vim.cmd("TSToolsOrganizeImports")
          vim.cmd("TSToolsAddMissingImports")
        end
        vim.lsp.buf.format({ timeout = 10000 })
      end,
      desc = "Format according to null-ls",
    },
    ["ga"] = { cmd = ":Git blame<CR>", desc = "Run git blame" },
    ["gc"] = { cmd = ":Git commit<CR>", desc = "Commit" },
    ["gp"] = { cmd = ":Git push<CR>", desc = "Git push" },
    ["gas"] = { cmd = ":Git stash<CR>", desc = "Git stash all" },
    ["gap"] = { cmd = ":Git stash pop<CR>", desc = "Git stash pop" },
    ["git"] = { cmd = ":Git<CR>", desc = "Git" },
    ["<C-a>"] = {
      cmd = function()
        vim.notify("Added file to harpoon")
        require("harpoon.mark").add_file()
      end,
      desc = "Harpoon add file",
    },
    ["<C-e>"] = {
      cmd = function()
        require("harpoon.ui").toggle_quick_menu()
      end,
      desc = "Harpoon toggle menu",
    },
    ["<leader>1"] = {
      cmd = function()
        require("harpoon.ui").nav_file(1)
      end,
      desc = "Harpoon nav file 1",
    },
    ["<leader>2"] = {
      cmd = function()
        require("harpoon.ui").nav_file(2)
      end,
      desc = "Harpoon nav file 2",
    },
    ["<leader>3"] = {
      cmd = function()
        require("harpoon.ui").nav_file(3)
      end,
      desc = "Harpoon nav file 3",
    },
    ["<leader>4"] = {
      cmd = function()
        require("harpoon.ui").nav_file(4)
      end,
      desc = "Harpoon nav file 4",
    },
    ["<leader>5"] = {
      cmd = function()
        require("harpoon.ui").nav_file(5)
      end,
      desc = "Harpoon nav file 5",
    },
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
