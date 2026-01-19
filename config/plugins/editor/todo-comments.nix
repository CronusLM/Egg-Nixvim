{
  plugins.todo-comments.enable = true;
  plugins.todo-comments.lazyLoad = {
    enable = true;
    settings = {
      event = "User LazyFile";
      keys = [
        {
          __unkeyed-1 = "<leader>ft";
          __unkeyed-3 = "<cmd>Telescope todo-comments todo theme=dropdown<cr>";
          desc = "Todo 查询";
        }
      ];
    };
  };
  plugins.todo-comments.settings = {
    signs = true;
  };
}
