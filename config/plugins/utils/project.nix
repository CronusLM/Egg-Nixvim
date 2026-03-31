{
  plugins.project-nvim = {
    enable = true;
    lazyLoad = {
      enable = true;
      settings.event = "User CookLazy";
    };
    # enableTelescope = true;
    settings = {
      excludeDirs = [];
      lsp.enabled = true;
      patterns = [
        ".git"
        "Makefile"
        "package.json"
        "pyproject.toml"
        "Cargo.toml"
        ".project-root"
      ];
      auto_cd = true;
    };
  };
}
