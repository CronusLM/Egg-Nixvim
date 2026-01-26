# CookNixvim

一个使用 Nix 构建的模块化 Neovim 配置。一键安装轻松使用、功能齐全。

## 使用说明

> [!TIP]
> 建议使用**快速体验**体验该配置，在决定使用什么方式安装  
> 自定义安装的文件修改的注意事项见下方

|    安装方式    |          说明          | 命令                                             |
| :------------: | :--------------------: | :----------------------------------------------- |
|  **快速体验**  | 临时运行，不安装到系统 | `nix run github:Youthdreamer/CookNixvim`         |
|  **永久安装**  |   安装到 Nix profile   | `nix profile add github:Youthdreamer/CookNixvim` |
| **自定义安装** | 需要先 Fork 并修改配置 | `nix profile add github:[用户名]/[仓库名]`       |

> [!NOTE]
> 非 Nixos 用户，需要安装 [Nix Manager](https://nixos.org/download/) 进行安装并开启 flakes 与 nix-command 功能  
> 功能开启方式推荐在 `~/.config/nix/nix.conf` 中写入 `experimental-features = nix-command flakes` 并重启终端

## 目录结构

#### **core/ 核心全局通用设置**

- autocmd.nix 功能性自动命令，例如：该配置中的自定义懒加载事件 `User CookLazy` 与 `User LazyFile`
- basic.nix neovim 全局设置，例如：相对行号、搜索设置等
- keymap.nix 通用快捷键设置，例如：行移动、全选、窗口大小调整等

#### **neovide/ neovide 的简单配置（未安装 [neovide](https://neovide.dev/) 不影响使用）**

- basic.nix neovide 全局配置，例如：光标动画等
- keymap.nix neovide 快捷键，例如：UI缩放快捷键等

#### **plugins/ 按功能划分的插件模块**

- **ai**
  - AI模块
  - 简单配置的 [avante.nvim](https://github.com/yetone/avante.nvim) 插件
  - 配置了千问与 deepseek 的 API 使用
  - 如果是其他 API 提供商请重新自行配置

- **colorschemes**
  - 主题切换模块（使用 lua 编写）
  - 预配置了50个第三方主题插件
  - 暂不支持 dark/light 切换
  - 请预先在 theme-list.lua 中设置主题名称

- **dap**
  - 调试器模块
  - 该模块默认提供简单的 c、cpp、rust、js/ts、go 的调试器配置与调试器 UI

- **dependencies**
  - 依赖模块
  - 默认提供 ripgrep 与 lazygit 的安装
  - 其他相关软件安装可查看 [nixvim](https://nix-community.github.io/nixvim/index.html) 官方文档支持

- **editor**
  - 编辑器增强模块
  - 编辑器核心交互配置
  - 提供结构导航、视觉辅助、文件管理等功能

- **git**
  - Git模块
  - lazygit 集成
  - Git 行级状态显示

- **github**
  - Github模块
  - 从 Github 上下载第三方插件
  - 提供 nixvim 官方不支持的第三方插件
  - 提供了代码示例

- **lsp**
  - Lsp模块
  - 语言的智能补全，格式化等功能
  - 其中 `lint.nix` 默认关闭（通常不需要开启）
  - Lsp配置中提供 `eslint`

- **snippets**
  - 代码片段模块
  - 参考: [friendly-snippets](https://github.com/rafamadriz/friendly-snippets)

- **ui**
  - UI模块
  - 给模块提供 bufferline、lualine、启动界面等
  - 提升视觉体验

- **utils**
  - 工具模块
  - 提供搜索、跳转、任务管理等工具类插件
  - 提升使用效率与操作顺畅度

## 复制粘贴功能说明

鉴于该配置可能运行在远程 SSH 会话中，为保证跨系统复制粘贴的可用性，引入了基于 [OSC52](https://neovim.io/doc/user/provider.html#clipboard-osc52) 的剪贴板传输方案。采用 OSC52 的粘贴功能可能会导致编辑器卡住数十秒，所以禁用该粘贴功能，也就是你无法使用 p 粘贴从系统中复制的内容，但是可以将编辑器中的内容复制到系统剪切板中，使用系统自身的粘贴快捷键将从系统复制的内容粘贴到编辑器中。该配置位置位于 `config/core/basic.nix` 可根据自身需求调整。

## 启动速度说明

禁用 dashborad 该插件，可大幅提升首页加载速度（不影响打开文件速度）。如不需要，请fork该仓库注释掉该插件或移除，以提升加载速度。

## 其余内容

Coming soon.
