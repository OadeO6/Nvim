require("ade.set")
require("ade.remap")
require("ade.lazy_init")

-- DO.not
-- DO NOT INCLUDE THIS

-- If i want to keep doing lsp debugging
-- function restart_htmx_lsp()
--     require("lsp-debug-tools").restart({ expected = {}, name = "htmx-lsp", cmd = { "htmx-lsp", "--level", "DEBUG" }, root_dir = vim.loop.cwd(), });
-- end

-- DO NOT INCLUDE THIS
-- DO.not
-- Go to last known cursor position when opening a file, except for gitcommit file type
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local ft = vim.bo.filetype
    if ft ~= "gitcommit" then
      local mark = vim.api.nvim_buf_get_mark(0, '"')
      local lcount = vim.api.nvim_buf_line_count(0)
      if mark[1] > 0 and mark[1] <= lcount then
        pcall(vim.api.nvim_win_set_cursor, 0, mark)
      end
    end
  end,
})

--

local augroup = vim.api.nvim_create_augroup
local ThePrimeagenGroup = augroup('ThePrimeagen', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
    require("plenary.reload").reload_module(name)
end

vim.filetype.add({
    extension = {
        templ = 'templ',
    }
})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({"BufWritePre"}, {
    group = ThePrimeagenGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

autocmd('LspAttach', {
    group = ThePrimeagenGroup,
    callback = function(e)
        local opts = function(des)
            return { buffer = e.buf, desc = des }
        end

        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts("Go to Definition"))
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts("Hover Information"))
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts("Workspace Symbol"))
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts("Open Diagnostics"))
        vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts("Code Action"))
        vim.keymap.set("n", "<leader>gR", function() vim.lsp.buf.references() end, opts("Find References"))
        -- vim.keymap.set("n", "<leader>vR", function() vim.lsp.buf.references() end, opts("Find References"))
        vim.keymap.set("n", "<leader>vr", function() vim.lsp.buf.rename() end, opts("Rename Symbol"))
        vim.keymap.set("n", ";sv", function() vim.lsp.buf.rename() end, opts("Rename Variable"))
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts("Signature Help"))
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts("Next Diagnostic"))
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts("Previous Diagnostic"))
    end
})


-- edit the diagnostic error display
local function custom_diagnostic_format(diagnostic)
    return string.format("%d. %s  (source: %s)",
        diagnostic.lnum + 1, -- Line number
        diagnostic.message,  -- Error message
        diagnostic.source or "unknown" -- Source
    )
end

vim.diagnostic.config({
    virtual_text = {
        format = custom_diagnostic_format,
    },
    float = {
        --  format = custom_diagnostic_format,
        source = "always",
        border = "rounded"
    },
    severity_sort = true,
    update_in_insert = false,
})

--[[ -- Define a function to show diagnostics
local function show_diagnostics()
    local bufnr = vim.api.nvim_get_current_buf()
    local diagnostics = vim.diagnostic.get(bufnr)
    vim.diagnostic.set(nil, bufnr, diagnostics)
end

-- Define a function to clear diagnostics
local function clear_diagnostics()
    local bufnr = vim.api.nvim_get_current_buf()
    vim.diagnostic.reset(nil, bufnr)
end

-- Map keys to clear and show diagnostics
vim.api.nvim_set_keymap('n', '<leader>dc', '<cmd>lua clear_diagnostics()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ds', '<cmd>lua show_diagnostics()<CR>', { noremap = true, silent = true })

-- Autocommand to automatically show diagnostics on new error
vim.api.nvim_create_autocmd("DiagnosticChanged", {
    callback = function(args)
        if #args.diagnostics > 0 then
            show_diagnostics()
        end
    end,
}) --]]






vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
