#NOTE: C/C++/Rust 调试器
# 如不需要直接在 ../dap/default.nix中注释即可。未来需要再打开注释
{pkgs, ...}: {
  plugins.dap-lldb = {
    enable = true;
  };
  plugins.dap-lldb.lazyLoad = {
    enable = true;
    settings = {
      event = "User LazyFile";
    };
  };

  plugins.dap-lldb.settings = {
    codelldb_path = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb";
  };

  extraPackages = [
    pkgs.vscode-extensions.vadimcn.vscode-lldb
  ];
}
