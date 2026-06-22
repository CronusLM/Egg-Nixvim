{
  # opencode.nvim — 在 Neovim 中与 OpenCode AI 交互
  # 需要额外安装 opencode CLI: https://opencode.ai
  plugins.opencode = {
    enable = true;
    settings = {
      auto_reload = true;
    };
  };

  keymaps = [
    {
      mode = ["n" "x"];
      key = "<leader>A";
      action = ''
        <cmd>lua require("opencode").ask()<cr>
      '';
      options = {
        silent = true;
        desc = "Ask OpenCode";
      };
    }
    {
      mode = ["n" "t"];
      key = "<leader>At";
      action = ''
        <cmd>lua require("opencode").toggle()<cr>
      '';
      options = {
        silent = true;
        desc = "Toggle OpenCode";
      };
    }
  ];
}
