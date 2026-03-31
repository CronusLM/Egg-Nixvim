{
  imports = [
    ./core
    ./plugins
    ./neovide
  ];

  enableMan = true;
  enablePrintInit = true;
  # NOTE: 性能说明
  # Lua 字节码预编译（bytecode 编译）加速功能（默认不开启）
  # 让 Neovim 启动更快
  # 但是build时间变长，配置调试困难。推荐追求速度且不经常更改配置的同志们打开
  # plugins 该选项，会导致 telescope 的 keymaps 选项使用导致出现错误，所以暂时将该选项关闭
  # 尝试使用 excludedPlugins 选项将telescope排除但是并没有效果，所以选择不开启
  performance.byteCompileLua = {
    enable = true;
    configs = true;
    initLua = true;
    luaLib = true;
    nvimRuntime = true;
    # plugins = true;
  };
}
