-- lua/config/autocmds.lua

local autocmd = vim.api.nvim_create_autocmd

-- 📁 Automatically create missing directories before saving
autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
        local dir = vim.fn.expand("<afile>:p:h")
        if vim.fn.isdirectory(dir) == 0 then
            vim.fn.mkdir(dir, "p")
        end
    end,
    desc = "Auto-create directories before saving",
})

-- 💾 Auto-format on save (LSP based)
autocmd("BufWritePre", {
    pattern = { "*.c", "*.lua", "*.py", "*.js", "*.ts", "*.json", "*.html", "*.css" },
    callback = function()
        local clients = vim.lsp.get_active_clients({ bufnr = 0 })
        for _, client in ipairs(clients) do
            if client.supports_method("textDocument/formatting") then
                vim.lsp.buf.format({ async = false })
                return
            end
        end
    end,
    desc = "Format on save with LSP",
})

-- 🖱️ Highlight on yank
autocmd("TextYankPost", {
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ timeout = 200 })
    end,
    desc = "Highlight yanked text",
})

-- 🧠 Restore cursor to last known position
autocmd("BufReadPost", {
    callback = function()
        local pos = vim.fn.line("'\"")
        if pos > 0 and pos <= vim.fn.line("$") then
            vim.cmd("normal! g`\"")
        end
    end,
    desc = "Restore cursor on reopen",
})

-- 🪟 Resize splits equally when window is resized
autocmd("VimResized", {
    callback = function()
        vim.cmd("tabdo wincmd =")
    end,
    desc = "Auto-resize splits on window resize",
})
