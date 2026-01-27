# CookNixvim

一个使用 Nix 构建的模块化 Neovim 配置。一键安装轻松使用、功能齐全。

## 使用说明

> [!WARNING]
> **⚠️ 自定义安装用户请注意：不要盲目信任第三方缓存**
>
> 本配置中使用了 Cachix 管理缓存，为方便使用本配置的构建缓存，所以在 [`flake.nix`](./flake.nix) 中配置了缓存地址如下：
>
> ```nix
> nixConfig = {
>   extra-substituters = [
>     "https://cook-nixvim.cachix.org"
>   ];
>   extra-trusted-public-keys = [
>     "cook-nixvim.cachix.org-1:LjCZ3VSYrcwTQxHpd834EIswdkfHoSd/EsKUYLRruF4="
>   ];
> };
> ```
>
> !!! 如果你是**自定义安装**，**请务必删掉该段代码或更换为你自己的缓存地址**
> 如果你使用该配置，则无需修改，保持该配置，无需本地构建会从缓存地址下载构建好的缓存减少安装耗时，大幅提升安装体验。

**独立安装**

> [!TIP]
> 建议使用**快速体验**体验该配置，在决定使用什么方式安装  
> 自定义安装的文件修改的**注意事项见下方**

|    安装方式    |          说明          | 命令                                             |
| :------------: | :--------------------: | :----------------------------------------------- |
|  **快速体验**  | 临时运行，不安装到系统 | `nix run github:Youthdreamer/CookNixvim`         |
|  **永久安装**  |   安装到 Nix profile   | `nix profile add github:Youthdreamer/CookNixvim` |
| **自定义安装** | 需要先 Fork 并修改配置 | `nix profile add github:[用户名]/[仓库名]`       |

> [!NOTE]
> 非 Nixos 用户，需要安装 [**`Nix Manager`**](https://nixos.org/download/) 并开启 `flakes` 与 `nix-command` 功能  
> 功能开启方式推荐在 `~/.config/nix/nix.conf` 中写入 `experimental-features = nix-command flakes` 并重启终端

**使用Flake安装**

> [!TIP]
> 推荐使用 `Nixos` 的用户可以使用该方式，集成度更高

在 `flake.nix` 非常方便的导入

```nix
{
  inputs = {
    CookNixvim.url = "github:Youthdreamer/CookNixvim";
  }
}
```

安装到系统中，可以在 `inputs` 中引入，或者为其名

```nix
{ inputs, system, ...}:
{
  # NixOS
  environment.systemPackages = [ inputs.CookNixvim.packages.${pkgs.system}.default ];
  # home-manager
  home.packages = [ inputs.CookNixvim.packages.${pkgs.system}.default ];
}
```

之后就可以输入 **`nvim`** 命令使用编辑器

## 目录结构

### core/

核心全局通用设置

<details>
   <summary><strong>通用配置详情</strong></summary>

- **[autocmd](./config/core/autocmd.nix)**
  - 功能性自动命令
  - 包含自定义懒加载事件 `User CookLazy` 与 `User LazyFile` 等
- **[basic](./config/core/basic.nix)**
  - neovim 全局基础设置
  - 包含相对行号、搜索设置等
- **[keymap](./config/core/keymap.nix)**
  - 通用快捷键设置
  - 包含行移动、全选、窗口大小调整等常用快捷键等
  </details>

### neovide/

Neovide 专用配置

> 未安装 [neovide](https://neovide.dev/) 不影响使用

<details>
   <summary><strong>Neovide配置详情</strong></summary>

- **[basic](./config/neovide/basic.nix)**
  - Neovide 全局配置
  - 光标动画等
- **[keymap](./config/neovide/keymap.nix)**
  - Neovide 快捷键
  - UI缩放快捷键等

</details>

### plugins/

按功能划分的插件模块

> [!NOTE]
> **`obsess`** 插件被作为安装 `github` 中未被 [**`nixvim`**](https://nix-community.github.io/nixvim) 支持的插件的代码例子，默认保持开启
> `lint` 插件仅仅为 `JS/TS` 配置，使用 `eslint_d`，插件默认保持关闭，因为 `lsp` 中启用了 `eslint`
> AI 插件 `avante` 目前只配置了 `deepseek` 、千问等 API 配置，如果使用其他 API 提供商请自行修改配置

<details>
   <summary><strong>插件列表详情</strong></summary>

- ai
  AI 相关插件，用于代码辅助与对话式编辑
  - **[avante](./config/plugins/ai/avante.nix)**: 基于大模型的代码助手，支持对话、修改与生成代码
  - **[blink-cmp-avante](./config/plugins/ai/blink-cmp-avante.nix)**: 将 Avante 能力接入补全系统，提供 AI 辅助补全体验
- **[colorschemes/](./config/plugins/colorschemes/)**: 统一管理并切换多款第三方配色主题
- dap
  调试相关插件，提供统一的调试体验
  - **[nvim-dap](./config/plugins/dap/dap.nix)**: Neovim 的核心调试框架
  - **[nvim-dap-ui](./config/plugins/dap/dap-ui.nix)**: 为 nvim-dap 提供可视化调试界面
  - **[dap-lldb](./config/plugins/dap/languages/dap-lldb.nix)**: 基于 LLDB 的 C / C++ / Rust 调试配置
  - **[dap-go](./config/plugins/dap/languages/dap-go.nix)**: Go 语言调试支持
  - **[dap-js](./config/plugins/dap/languages/dap-js.nix)**: 通过 dap 简单配置的 js/ts 调试器配置
- **[dependencies](./config/plugins/dependencies/default.nix)**: 提供常用命令行工具的统一安装与管理
- editor
  编辑体验增强插件
  - **[aerial](./config/plugins/editor/aerial.nix)**: 提供代码结构大纲与符号导航
  - **[autotag](./config/plugins/editor/autotag.nix)**: 自动补全与更新成对标签
  - **[indent-blankline](./config/plugins/editor/indent-blankline.nix)**: 显示缩进参考线，提升代码层级可读性
  - **[mini-files](./config/plugins/editor/mini-files.nix)**: 轻量级文件管理器
  - **[mini-indentscope](./config/plugins/editor/mini-indentscope.nix)**: 高亮当前缩进作用域
  - **[neo-tree](./config/plugins/editor/neo-tree.nix)**: 功能完整的文件树浏览器
  - **[rainbow-delimiters](./config/plugins/editor/rainbow-delimiters.nix)**: 使用不同颜色高亮成对括号
  - **[todo-comments](./config/plugins/editor/todo-comments.nix)**: 高亮并管理代码中的 TODO / FIXME 注释
  - **[treesitter](./config/plugins/editor/treesitter.nix)**: 基于语法树的高亮与代码分析
  - **[ufo](./config/plugins/editor/ufo.nix)**: 提供更强大的代码折叠能力
- git
  Git 集成相关插件
  - **[gitsigns](./config/plugins/git/gitsigns.nix)**: 显示行级 Git 变更信息
  - **[lazygit](./config/plugins/git/lazygit.nix)**: 在 Neovim 中集成 lazygit 界面
- github
  GitHub 相关插件
  - **[obsess](./config/plugins/github/obsess.nix)**: 自定义计时任务插件，作为安装 github 插件的范例
- lsp
  语言服务器与代码质量插件
  - **[lsp](./config/plugins/lsp/lsp.nix)**: LSP 核心配置，提供补全与诊断能力
  - **[blink](./config/plugins/lsp/blink.nix)**: 补全体验增强插件
  - **[conform](./config/plugins/lsp/conform.nix)**: 统一的代码格式化工具管理
  - **[fidget](./config/plugins/lsp/fidget.nix)**: 显示 LSP 状态与进度提示
  - **[lint](./config/plugins/lsp/lint.nix)**: 代码静态检查功能（默认关闭）
- snippets
  代码片段管理
  - **[friendly-snippets](./config/plugins/snippets/friendly-snippets.nix)**: 提供丰富的通用代码片段集合
- ui
  界面与视觉增强插件
  - **[bufferline](./config/plugins/ui/bufferline.nix)**: 显示并管理打开的缓冲区
  - **[colorizer](./config/plugins/ui/colorizer.nix)**: 实时高亮颜色值
  - **[dashborad](./config/plugins/ui/dashboard.nix)**: 自定义 Neovim 启动界面
  - **[dressing](./config/plugins/ui/dressing.nix)**: 优化输入框与选择菜单 UI
  - **[lualine](./config/plugins/ui/lualine.nix)**: 轻量且高度可定制的状态栏
  - **[noice](./config/plugins/ui/noice.nix)**: 重构消息、命令行与通知 UI
  - **[transparent](./config/plugins/ui/transparent.nix)**: 提供透明背景支持
- utils
  通用效率工具插件
  - **[flash](./config/plugins/utils/flash.nix)**: 快速跳转到任意位置
  - **[harpoon](./config/plugins/utils/harpoon.nix)**: 快速标记并切换常用文件
  - **[img-clip](./config/plugins/utils/img-clip.nix)**: 将图片粘贴为本地文件或链接
  - **[markdown-preview](./config/plugins/utils/markdown-preview.nix)**: 实时预览 Markdown 文件
  - **[persistence](./config/plugins/utils/persistence.nix)**: 自动保存并恢复会话状态
  - **[project](./config/plugins/utils/project.nix)**: 项目管理与快速切换
  - **[render-markdown](./config/plugins/utils/render-markdown.nix)**: 在 Neovim 中渲染 Markdown 样式
  - **[surround](./config/plugins/utils/surround.nix)**: 快速添加、修改或删除包围符号
  - **[telescope](./config/plugins/utils/telescope.nix)**: 强大的模糊搜索与选择框架
  - **[toggleterm](./config/plugins/utils/toggleterm.nix)**: 内嵌终端管理
  - **[trouble](./config/plugins/utils/trouble.nix)**: 统一展示诊断、引用与错误列表
  - **[typst-preview](./config/plugins/utils/typst-preview.nix)**: 实时预览 Typst 文件
  - **[which-key](./config/plugins/utils/which-key.nix)**: 提示并引导快捷键使用

</details>

## 复制粘贴功能说明

> **TL;DR：可以在 SSH 链接的终端中复制编辑器内容到系统，但不能直接 `p` 粘贴系统内容**

鉴于该配置可能**运行在远程 SSH 会话中**，为保证**跨系统复制粘贴**的可用性，引入了基于 **[OSC52](https://neovim.io/doc/user/provider.html#clipboard-osc52)** 的剪贴板传输方案。**采用 OSC52 的粘贴功能可能会导致编辑器卡住数十秒**，所以**禁用该粘贴功能**，也就是你无法使用 `p` 粘贴从系统中复制的内容，但是可以将编辑器中的内容复制到系统剪切板中，使用**系统自身**的粘贴快捷键将从系统复制的内容粘贴到编辑器中。该配置位置位于 `config/core/basic.nix` 可根据自身需求调整。

## 启动速度说明

禁用 dashborad 该插件，可大幅提升首页加载速度（不影响打开文件速度）。如不需要，请fork该仓库注释掉该插件或移除，以提升加载速度。

## 其余内容

Coming soon.
