-- ==========================================================================================
-- 🚀 Save File
-- ==========================================================================================
vim.keymap.set({ 'n', 'i' }, '<C-s>', function()
    vim.cmd('write')
end, { desc = "Save current file" })

-- ==========================================================================================
-- 🔍 Telescope
-- ==========================================================================================
vim.keymap.set("n", "<leader>ff", function()
    require("telescope.builtin").find_files({
        cwd = vim.fn.expand("$HOME"), -- Search home directory
        hidden = true,
        find_command = { "fd", "--hidden", "--exclude", ".git" },
    })
end, { desc = "Find files including dotfiles in $HOME" })

-- ==========================================================================================
-- 🧪 Run Code (F5–F7)
-- ==========================================================================================
local runner = require("config.run-code")

vim.keymap.set("n", "<F5>", function()
    runner.run("python3 %s")
end, { noremap = true, silent = true, desc = "Run Python code" })


vim.keymap.set("n", "<F6>", function()
    runner.run("g++ %s -o out && ./out")
end, { noremap = true, silent = true, desc = "Compile & run C++ code" })


vim.keymap.set("n", "<F7>", function()
    runner.run("lua %s")
end, { noremap = true, silent = true, desc = "Run Lua code" })

vim.keymap.set("n", "<F8>", function() runner.run("gcc %s -o out && ./out") end,
    { noremap = true, silent = true, desc = "Compile & run C code" })
-- ==========================================================================================
-- 📂 Buffer Navigation
-- ==========================================================================================
vim.keymap.set("n", "<A-p>", "<cmd>bprev<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<A-n>", "<cmd>bnext<CR>", { desc = "Next buffer" })


-- ==========================================================================================
-- 🪟 Window Navigation (Splits)
-- ==========================================================================================
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to upper split" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to lower split" })

-- ==========================================================================================
-- 🧹 Buffer Utils
-- ==========================================================================================
vim.keymap.set("n", "<C-q>", "<cmd>bd<CR>", { desc = "Close current buffer" })
vim.keymap.set("n", "<C-a>", "ggVG", { noremap = true, silent = true, desc = "Select all" })
