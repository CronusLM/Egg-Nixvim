# NOTE: 在../dependencies中依旧安装好了lazygit
{
  plugins.lazygit.enable = true;
  plugins.lazygit.lazyLoad = {
    enable = true;
    settings = {
      cmd = "LazyGit";
      keys = [
        {
          __unkeyed-1 = "<leader>gg";
          __unkeyed-3 = "<cmd>LazyGit<cr>";
          desc = "打开LazyGit界面";
        }
      ];
    };
  };
}
