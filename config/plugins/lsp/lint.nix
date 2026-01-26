{pkgs, ...}: {
  extraPackages = [
    pkgs.eslint_d
  ];
  # NOTE: 默认关闭，开启请使用 enable = true
  plugins.lint.enable = false;
  plugins.lint.lazyLoad = {
    enable = true;
    settings = {
      event = ["User CookLazy"];
    };
  };
  plugins.lint.lintersByFt = {
    javascript = ["eslint_d"];
    typescript = ["eslint_d"];
    javascriptreact = ["eslint_d"];
    typescriptreact = ["eslint_d"];
  };
  plugins.lint.autoCmd = {
    event = ["BufWritePost" "InsertLeave"];
    callback = {
      __raw = ''
        function()
          require('lint').try_lint()
        end
      '';
    };
  };
}
