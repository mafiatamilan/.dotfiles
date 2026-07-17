-- Black, Red & White Theme for Neovim

-- Custom Colors
local colors = {
  black   = "#000000",
  red     = "#FF0000",
  white   = "#FFFFFF",
  gray    = "#333333",
  darkgray = "#1A1A1A",
  lightgray = "#666666",
}

-- Highlight Groups
local highlights = {
  -- General
  Normal       = { fg = colors.white, bg = colors.black },
  Cursor       = { fg = colors.black, bg = colors.red },
  CursorLine   = { bg = colors.darkgray },
  CursorColumn = { bg = colors.darkgray },
  ColorColumn  = { bg = colors.gray },
  LineNr       = { fg = colors.lightgray, bg = colors.black },
  CursorLineNr = { fg = colors.red, bg = colors.darkgray },

  -- Syntax
  Comment      = { fg = colors.lightgray, italic = true },
  Constant     = { fg = colors.red },
  String       = { fg = colors.white },
  Character    = { fg = colors.red },
  Number       = { fg = colors.red },
  Boolean      = { fg = colors.red },
  Identifier   = { fg = colors.white },
  Function     = { fg = colors.red, bold = true },
  Statement    = { fg = colors.red, bold = true },
  Keyword      = { fg = colors.red, bold = true },
  PreProc      = { fg = colors.red },
  Type         = { fg = colors.white, bold = true },
  Special      = { fg = colors.red },
  Error        = { fg = colors.red, bold = true },
  Todo         = { fg = colors.red, bg = colors.black, bold = true },

  -- UI
  Visual       = { bg = colors.gray },
  Search       = { fg = colors.black, bg = colors.red },
  IncSearch    = { fg = colors.black, bg = colors.red },
  StatusLine   = { fg = colors.white, bg = colors.gray, bold = true },
  StatusLineNC = { fg = colors.lightgray, bg = colors.darkgray },
  TabLine      = { fg = colors.white, bg = colors.gray },
  TabLineFill  = { bg = colors.darkgray },
  TabLineSel   = { fg = colors.red, bg = colors.black, bold = true },

  -- Popups
  Pmenu        = { fg = colors.white, bg = colors.darkgray },
  PmenuSel     = { fg = colors.black, bg = colors.red },
  PmenuSbar    = { bg = colors.gray },
  PmenuThumb   = { bg = colors.red },

  -- Diff
  DiffAdd      = { fg = colors.white, bg = colors.red },
  DiffChange   = { fg = colors.white, bg = colors.gray },
  DiffDelete   = { fg = colors.red, bg = colors.black },
  DiffText     = { fg = colors.white, bg = colors.red, bold = true },

  -- Spelling
  SpellBad     = { fg = colors.red, undercurl = true },
  SpellCap     = { fg = colors.white, undercurl = true },

  -- Matching
  MatchParen   = { fg = colors.red, bg = colors.gray, bold = true },

  -- Sign Column
  SignColumn   = { fg = colors.red, bg = colors.black },

  -- Float
  FloatBorder  = { fg = colors.red, bg = colors.black },
  FloatTitle   = { fg = colors.red, bg = colors.black, bold = true },

  -- Diagnostic
  DiagnosticError = { fg = colors.red },
  DiagnosticWarn  = { fg = colors.red },
  DiagnosticInfo  = { fg = colors.white },
  DiagnosticHint  = { fg = colors.lightgray },

  -- Git
  GitSignsAdd    = { fg = colors.red },
  GitSignsChange = { fg = colors.white },
  GitSignsDelete = { fg = colors.red },
}

-- Apply highlights
for group, opts in pairs(highlights) do
  vim.api.nvim_set_hl(0, group, opts)
end

-- Clipboard
vim.g.clipboard = {
  name = "xclip",
  copy = {
    ["+"] = "xclip -selection clipboard",
    ["*"] = "xclip -selection clipboard",
  },
  paste = {
    ["+"] = "xclip -selection clipboard -o",
    ["*"] = "xclip -selection clipboard -o",
  },
}

-- Lazy.nvim Bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Plugin Spec
  { "nvim-lua/plenary.nvim" },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({
        ensure_installed = { "lua", "vim", "vimdoc", "javascript", "typescript", "python", "rust", "go", "html", "css", "json", "yaml", "markdown" },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")

      mason.setup()
      mason_lspconfig.setup({
        ensure_installed = { "lua_ls", "pyright", "ts_ls", "rust_analyzer" },
      })

      local on_attach = function(_, bufnr)
        local opts = { buffer = bufnr, silent = true }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, opts)
      end

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local servers = { "lua_ls", "pyright", "ts_ls", "rust_analyzer" }
      for _, server in ipairs(servers) do
        vim.lsp.config(server, {
          on_attach = on_attach,
          capabilities = capabilities,
        })
        vim.lsp.enable(server)
      end
    end,
  },

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup()
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help Tags" })
    end,
  },

  -- Git Signs
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },

  -- Comment
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },

  -- Which Key
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup()
    end,
  },

  -- Lualine
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = {
            normal = { a = { fg = "#000000", bg = "#FF0000", bold = true }, b = { fg = "#FFFFFF", bg = "#333333" }, c = { fg = "#FFFFFF", bg = "#1A1A1A" } },
            insert = { a = { fg = "#000000", bg = "#FFFFFF", bold = true } },
            visual = { a = { fg = "#FF0000", bg = "#000000", bold = true } },
            replace = { a = { fg = "#000000", bg = "#FF0000", bold = true } },
            command = { a = { fg = "#FF0000", bg = "#FFFFFF", bold = true } },
          },
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "filename", "branch" },
          lualine_c = {},
          lualine_x = { "diagnostics", "filetype" },
          lualine_y = { "encoding", "fileformat" },
          lualine_z = { "location" },
        },
      })
    end,
  },
})

-- Statusline
local function statusmode()
  local mode = vim.api.nvim_get_mode().mode
  local modes = {
    ["n"]      = "NORMAL",
    ["i"]      = "INSERT",
    ["v"]      = "VISUAL",
    ["V"]      = "V-LINE",
    ["\22"]    = "V-BLOCK",
    ["R"]      = "REPLACE",
    ["c"]      = "COMMAND",
    ["s"]      = "SELECT",
    ["S"]      = "S-LINE",
    ["\19"]    = "S-BLOCK",
    ["t"]      = "TERM",
  }
  return modes[mode] or mode
end

local function get_git_branch()
  local branch = vim.fn.system("git branch --show-name 2>/dev/null | head -n1")
  if vim.v.shell_error ~= 0 then return "" end
  branch = branch:gsub("\n", "")
  if branch ~= "" then return branch end
  return ""
end

local function get_diagnostics()
  local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
  local warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
  local info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
  local hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })

  local parts = {}
  if errors > 0 then table.insert(parts, "%#StlDiagError# E:" .. errors .. " ") end
  if warnings > 0 then table.insert(parts, "%#StlDiagWarn# W:" .. warnings .. " ") end
  if info > 0 then table.insert(parts, "%#StlDiagInfo# I:" .. info .. " ") end
  if hints > 0 then table.insert(parts, "%#StlDiagHint# H:" .. hints .. " ") end
  return table.concat(parts)
end

local function get_filetype()
  local ft = vim.bo.filetype
  if ft == "" then return "" end
  return ft
end

-- Statusline Highlight Groups
local stl_highlights = {
  StlLeftRed     = { fg = colors.black, bg = colors.red, bold = true },
  StlLeftWhite  = { fg = colors.black, bg = colors.white, bold = true },
  StlLeftGray   = { fg = colors.white, bg = colors.gray },
  StlRightGray  = { fg = colors.lightgray, bg = colors.darkgray },
  StlRightRed   = { fg = colors.white, bg = colors.red, bold = true },
  StlRightWhite = { fg = colors.black, bg = colors.white, bold = true },
  StlMid        = { fg = colors.lightgray, bg = colors.darkgray },
  StlEmpty      = { bg = colors.darkgray },
  StlDiagError  = { fg = colors.red, bg = colors.darkgray, bold = true },
  StlDiagWarn   = { fg = colors.white, bg = colors.gray, bold = true },
  StlDiagInfo   = { fg = colors.lightgray, bg = colors.darkgray },
  StlDiagHint   = { fg = colors.gray, bg = colors.darkgray },
  StlFilename   = { fg = colors.white, bg = colors.gray, bold = true },
  StlModified   = { fg = colors.red, bg = colors.gray, bold = true },
  StlBranch     = { fg = colors.white, bg = colors.red, bold = true },
  StlSep        = { fg = colors.gray, bg = colors.darkgray },
}

for group, opts in pairs(stl_highlights) do
  vim.api.nvim_set_hl(0, group, opts)
end

-- Statusline setup
vim.api.nvim_create_autocmd({ "ModeChanged", "BufEnter", "DiagnosticChanged" }, {
  callback = function()
    local mode = vim.api.nvim_get_mode().mode
    local mode_hl
    local mode_label

    if mode == "i" then
      mode_hl = "%#StlLeftRed#"
      mode_label = " INSERT "
    elseif mode == "v" or mode == "V" or mode == "\22" then
      mode_hl = "%#StlLeftRed#"
      mode_label = " VISUAL "
    elseif mode == "R" or mode == "Rv" then
      mode_hl = "%#StlLeftRed#"
      mode_label = " REPLACE "
    elseif mode == "c" then
      mode_hl = "%#StlLeftWhite#"
      mode_label = " COMMAND "
    else
      mode_hl = "%#StlLeftWhite#"
      mode_label = " NORMAL "
    end

    local branch = get_git_branch()
    local branch_section = ""
    if branch ~= "" then
      branch_section = "%#StlSep# " .. "%#StlBranch# " .. branch .. " "
    end

    local modified = vim.bo.modified and "%#StlModified# + " or ""

    local stl = ""
      -- Left
      .. mode_hl .. mode_label
      .. "%#StlLeftGray# %f " .. modified
      .. "%#StlSep# "
      .. branch_section
      .. "%#StlMid#%= "
      -- Right
      .. get_diagnostics()
      .. "%#StlRightGray# "
      .. get_filetype() .. " "
      .. "%#StlRightRed# "
      .. vim.o.encoding .. " "
      .. "%#StlRightGray# "
      .. vim.bo.fileformat .. " "
      .. "%#StlRightWhite# "
      .. "%l:%c "
      .. "%#StlRightRed# "
      .. " %p%% "

    vim.opt.statusline = stl
  end,
})

vim.opt.laststatus = 2

-- Basic Settings
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus,unnamed"
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.scrolloff = 8
vim.opt.wrap = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Keymaps
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save" })
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })
vim.keymap.set("n", "<Esc>", ":noh<CR>", { desc = "Clear highlights" })
vim.keymap.set("v", "<", "<gv", { desc = "Indent left" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right" })
