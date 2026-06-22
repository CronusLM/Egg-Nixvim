# EggNixvim — Agent Guide

## 这是什么

EggNixvim 是一个基于 [nix-community/nixvim](https://nix-community.github.io/nixvim) 的模块化 Neovim 配置。配置本身是 Nix 代码，构建后生成可重复的 `nvim` 二进制。

## 核心命令

| 用途 | 命令 |
|------|------|
| 构建 | `nix build .` |
| 临时运行 | `nix run .` |
| 检查配置有效性 | `nix flake check .` |
| 查看最终 Lua 配置 | `nixvim-print-init`（构建后可用） |
| 保存 Lua 配置到文件 | `nixvim-print-init \| cat > my_init.lua` |
| 更新 flake 锁 | `nix flake update` |
| Cachix 推送缓存 | `cachix push egg-nixvim $(nix path-info .#packages.$system.egg-nixvim)` |

## 目录结构

```
config/
├── default.nix           # 主入口：导入 core/plugins/neovide
├── core/                  # 全局基础设置
│   ├── autocmd.nix        # 自动命令 + 自定义懒加载事件
│   ├── basic.nix          # Neovim 全局选项（行号、缩进、折叠等）
│   └── keymap.nix         # 通用快捷键映射
├── plugins/               # 所有插件配置（按类别分目录）
│   ├── default.nix        # 导入全部插件子目录，启用 lz-n / web-devicons
│   ├── ai/                # avante, blink-cmp-avante
│   ├── colorschemes/      # 主题插件 + 切换系统（theme-list.lua, switch-theme.lua）
│   ├── dap/               # 调试：nvim-dap + UI + 语言支持（lldb/go/js）
│   ├── dependencies/      # ripgrep, lazygit 等系统工具
│   ├── editor/            # treesitter, ufo, neo-tree, mini-* 等 11 个插件
│   ├── git/               # gitsigns, lazygit
│   ├── github/            # 从 GitHub 安装非 nixvim 官方插件（含 obsess 示例）
│   ├── lsp/               # lspconfig, blink, conform, fidget, lint（默认关闭）
│   ├── snippets/          # friendly-snippets
│   ├── ui/                # lualine, noice, bufferline, dashboard 等 8 个
│   └── utils/             # telescope, harpoon, which-key 等 14 个
└── neovide/               # Neovide 专用配置（basic + keymap）
```

## 架构要点

- **入口**: `flake.nix` 使用 `flake-parts`, 委托给 `config/` 目录下的 nixvim module
- **支持的平台**: `x86_64-linux`, `aarch64-linux`（macOS 平台未测试）
- **二进制缓存**: `egg-nixvim.cachix.org`（Fork 后需替换为自己的缓存地址）
- **主题切换**: 快捷键 `<leader>T`，主题列表在 `config/plugins/colorschemes/theme-list.lua`
- **懒加载**: 使用 `lz.n`（web-devicons 也是懒加载的）。两个自定义事件：
  - `User CookLazy` — VimEnter 后触发（就绪后加载次要插件）
  - `User LazyFile` — 首次 BufReadPost/BufNewFile 时触发（有文件时才加载的插件）
- **Bytecode 编译**：`performance.byteCompileLua` 已启用（plugins 项被注释掉——会导致 telescope keymaps 报错）

## 关键约定

- `<leader>` = 空格键
- 文件以 `.nix` 结尾（nixvim module 格式），部分配置嵌入 Lua
- `NOTE` 注释是重要的配置说明——修改前阅读
- **更改配置后必须重新构建才能生效**（不同于纯 Lua 配置的即时生效）
- `nix flake check .` 是快速验证配置有无语法错误的方式

## 添加新插件的标准模式

### 如果 nixvim 官方支持
在对应类别的 `.nix` 文件中添加 `plugins.<name>.enable = true;` 即可。

### 如果不支持（GitHub 插件）
参考 `config/plugins/github/obsess.nix`：

```nix
extraPlugins = [
  (pkgs.vimUtils.buildVimPlugin {
    name = "plugin-name";
    src = pkgs.fetchFromGitHub {
      owner = "owner";
      repo = "repo";
      rev = "...";       # commit hash
      hash = "...";      # 先不写，构建报错会给出正确值
    };
  })
];
extraConfigLua = ''
  require("lz.n").load {
    { "plugin-name", cmd = { "Cmd1", "Cmd2" }, after = function()
      require("plugin-name").setup({})
    end },
  }
'';
```

首次编写 hash 时留空或随便填，构建会报 hash mismatch 并给出正确的 SRI hash。

## 已知陷阱 / 注意事项

1. **lint 插件默认关闭**: `config/plugins/lsp/lint.nix` 因 LSP 已启用 eslint 所以默认关闭
2. **Bytecode 编译与 telescope 冲突**: `performance.byteCompileLua.plugins` 被注释——如果启用会导致 telescope keymaps 出错
3. **OSC52 粘贴被禁用**: SSH 环境下 OSC52 仅用于复制（粘贴可能导致卡顿数十秒），建议用系统粘贴快捷键
4. **dashboard + transparent 影响启动速度**: 如需更快首页加载可禁用这两个插件
5. **Avante AI**: 默认配置了 DeepSeek 和千问 API，使用其他提供商需自行修改 `config/plugins/ai/avante.nix`
6. **nil_ls 禁用了 flake autoArchive**: `autoArchive = false` 避免扫描时触发 archive 操作
7. **macOS 未测试**: 兼容性存疑，CI 中 darwin 构建默认注释
8. **`.gitignore`**: 只忽略 `result*`（nix build 符号链接）
9. **`result/` 目录**: 已有的 `result/` 是构建产物软链接，不应提交到 git
