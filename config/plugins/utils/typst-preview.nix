{
  plugins.typst-preview = {
    enable = true;
  };
  plugins.typst-preview.lazyLoad = {
    enable = true;
    settings = {
      ft = ["typst"];
      keys = [
        {
          __unkeyed-1 = "<leader>pt";
          __unkeyed-3 = "<cmd>TypstPreviewToggle<cr>";
          desc = "Typst内容预览";
        }
      ];
    };
  };
}
