{
  plugins.mini-files.enable = true;
  plugins.mini-files.lazyLoad = {
    enable = true;
    settings = {
      event = "User LazyFile";
      keys = [
        {
          __unkeyed-1 = "-";
          __unkeyed-3.__raw = ''
            function()
              MiniFiles.open()
            end
          '';
          desc = "快捷文件操作";
        }
      ];
    };
  };
  plugins.mini-files.settings = {
    windows = {
      preview = true;
    };
  };
}
