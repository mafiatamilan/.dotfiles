{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    plugins = with pkgs.vimPlugins; [
      gruvbox
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline
      luasnip
      cmp_luasnip
      friendly-snippets
      lspkind-nvim
      nvim-treesitter.withAllGrammars
      telescope-nvim
      plenary-nvim
      lualine-nvim
      vim-suda
    ];

    extraLuaPackages = luaPkgs: with luaPkgs; [
      lua-cjson
    ];
  };

  home.file.".config/nvim/init.lua".text = /* lua */ ''
    -- Your entire Lua config here
    -- Consider moving this into a separate init.lua file later for modularity
    vim.o.number = true
    vim.o.relativenumber = true
    vim.o.termguicolors = true
    vim.cmd("colorscheme gruvbox")
    -- ...
  '';
}

