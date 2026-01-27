{
  plugins.markdown-preview.enable = true;
  plugins.markdown-preview.lazyLoad = {
    enable = true;
    settings = {
      ft = ["markdown"];
      keys = [
        {
          __unkeyed-1 = "<leader>pm";
          __unkeyed-3 = "<cmd>MarkdownPreviewToggle<cr>";
          desc = "Markdown内容预览";
        }
      ];
    };
  };
}
