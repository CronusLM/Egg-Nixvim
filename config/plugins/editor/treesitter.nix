{config, ...}: {
  plugins.treesitter = {
    enable = true;
    folding.enable = false;
    indent.enable = true;
    highlight.enable = true;
    nixvimInjections = true;
    grammarPackages = with config.plugins.treesitter.package.builtGrammars; [
      bash # bashls
      c # clangd
      cpp # clangd
      cmake
      make
      ninja
      lua # lua_ls
      python # pyright, ruff
      rust # rust_analyzer
      go # gopls
      javascript # ts_ls
      typescript # ts_ls
      tsx
      html # html, emmet_ls
      css # cssls, stylelint_lsp
      json # jsonls
      toml # taplo
      nix # nil_ls
      markdown # marksman
      vim # vimscript
      vimdoc # vim help
      xml # 一些 XML 文件
      yaml # yaml 文件
      diff
    ];
  };

  plugins.treesitter.lazyLoad = {
    enable = true;
    settings = {
      event = ["User LazyFile" "User CookLazy"];
    };
  };
}
