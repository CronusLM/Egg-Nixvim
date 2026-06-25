{pkgs, ...}: {
  # opencode.nvim — 在 Neovim 中与 OpenCode AI 交互
  # 需要额外安装 opencode CLI: https://opencode.ai
  plugins.opencode = {
    enable = true;
    # nixpkgs v0.10.0 有 bug，用 v0.13.2
    package = pkgs.vimUtils.buildVimPlugin {
      name = "opencode-nvim-0.13.2";
      src = pkgs.fetchFromGitHub {
        owner = "nickjvandyke";
        repo = "opencode.nvim";
        rev = "c3271dee53af4ccb5c072dd807972d4b1e76e7d3";
        hash = "sha256-2+i0pA2Xn8OalHQ4yEnwLUnklT10r8rgE5qkc8k9754=";
      };
    };
    settings = {
      auto_reload = true;
    };
  };

  # 让 opencode CLI 在 Neovim 的 PATH 中可用
  extraPackages = [ pkgs.opencode ];

  keymaps = [
    {
      mode = ["n" "x"];
      key = "<leader>A";
      action = ''
        <cmd>lua require("opencode").ask("@this: ")<cr>
      '';
      options = {
        silent = true;
        desc = "Ask OpenCode";
      };
    }
    {
      mode = ["n" "x"];
      key = "<leader>As";
      action = ''
        <cmd>lua require("opencode").select()<cr>
      '';
      options = {
        silent = true;
        desc = "Select OpenCode action";
      };
    }
  ];
}
