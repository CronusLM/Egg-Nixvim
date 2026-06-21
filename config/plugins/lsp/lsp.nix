{
  plugins.lspconfig.enable = true;
  lsp.inlayHints.enable = true;
  lsp.servers = {
    # C/C++ 语言服务器
    clangd = {
      enable = true;
      packageFallback = true;
    };
    # CMake的LSP
    cmake = {
      enable = true;
      packageFallback = true;
    };
    # Rust 语言服务器
    rust_analyzer = {
      enable = true;
      packageFallback = true;
      config = {
        settings = {
          rust-analyzer = {
            check = {
              command = "clippy";
              onSave = true;
            };
            inlayHints = {
              enable = true;
              typeHints.enable = true;
              parameterHints.enable = true;
              chainingHints.enable = true;
            };
          };
        };
      };
    };
    # ts/js 语言服务器
    ts_ls = {
      enable = true;
      packageFallback = true;
    };
    # python 语言服务器
    basedpyright = {
      enable = true;
      packageFallback = true;
      config = {
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "standard";
              autoSearchPaths = true;
              useLibraryCodeForTypes = true;
              diagnosticMode = "openFilesOnly";
            };
          };
        };
      };
    };
    # Ruff
    ruff = {
      enable = true;
      packageFallback = true;
    };
    # lua 语言服务器
    lua_ls = {
      enable = true;
      config = {
        settings = {
          Lua = {
            diagnostics.globals = ["vim"];
            hint = {
              enable = false;
            };
          };
        };
      };
    };
    # go 语言服务器
    gopls = {
      enable = true;
      packageFallback = true;
    };
    # Shell 语言服务器
    bashls = {
      enable = true;
    };
    # Nix 语言服务器
    nil_ls = {
      enable = true;
      config = {
        settings = {
          nil = {
            nix = {
              flake = {
                autoArchive = false;
              };
            };
          };
        };
      };
    };
    # html
    html = {
      enable = true;
    };
    # css
    cssls = {
      enable = true;
    };
    # Tailwind CSS 语言服务器
    tailwindcss = {
      enable = true;
    };
    # Emmet 插件（通常用于 HTML, CSS, JS 文件）
    emmet_ls = {
      enable = true;
    };
    # eslint
    eslint = {
      enable = true;
      packageFallback = true;
    };
    # typst
    tinymist = {
      enable = true;
    };
    # json
    jsonls = {
      enable = true;
    };
    # toml
    taplo = {
      enable = true;
    };
    # markdown
    marksman = {
      enable = true;
    };
    # yaml
    yamlls = {
      enable = true;
      config = {
        settings = {
          yaml = {
            schemas = {
              "https://json.schemastore.org/github-workflow" = ".github/workflows/*";
              "https://json.schemastore.org/github-action" = ".github/action.{yml,yaml}";
              "https://json.schemastore.org/ansible-stable-2.9" = "roles/tasks/*.{yml,yaml}";
              "https://json.schemastore.org/ansible-playbook" = "*play*.{yml,yaml}";
              "https://json.schemastore.org/kustomization" = "kustomization.{yml,yaml}";
              "https://json.schemastore.org/chart" = "Chart.{yml,yaml}";
              "https://json.schemastore.org/dependabot-v2" = ".github/dependabot.{yml,yaml}";

              # Docker Compose — fully recommended
              "https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json" = [
                "docker-compose.{yml,yaml}"
                "*compose*.{yml,yaml}"
              ];

              "https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json" = "*flow*.{yml,yaml}";
            };
          };
        };
      };
    };
  };

  keymaps = [
    # 悬浮信息
    {
      key = "K";
      action = "<cmd>lua vim.lsp.buf.hover()<cr>";
      options.desc = "显示悬浮文档 / 悬浮信息";
    }
    # 查找实现/引用
    {
      key = "<leader>ci";
      action = "<cmd>Telescope lsp_implementations<cr>";
      options.desc = "查找实现";
    }
    {
      key = "<leader>cr";
      action = "<cmd>Telescope lsp_references<cr>";
      options.desc = "查找引用";
    }
    # 代码结构查看
    {
      key = "<leader>cw";
      action = "<cmd>Telescope lsp_workspace_symbols<cr>";
      options.desc = "查找工作区符号";
    }
    {
      key = "<leader>cf";
      action = "<cmd>Telescope lsp_document_symbols<cr>";
      options.desc = "文件大纲";
    }
    # 代码关系查看
    {
      key = "<leader>c[";
      action = "<cmd>Telescope lsp_incoming_calls<cr>";
      options.desc = "被调列表";
    }
    {
      key = "<leader>c]";
      action = "<cmd>Telescope lsp_outgoing_calls<cr>";
      options.desc = "调用列表";
    }
    # 诊断查看
    {
      key = "<leader>ce";
      action = "<cmd>Telescope diagnostics bufnr=0<cr>";
      options.desc = "当前文件诊断";
    }
    {
      key = "<leader>cW";
      action = "<cmd>Telescope diagnostics<cr>";
      options.desc = "全局诊断";
    }
    {
      key = "<leader>D";
      action = "<cmd>lua vim.diagnostic.open_float()<cr>";
      options.desc = "显示诊断信息 (浮窗)";
    }
    {
      key = "<leader>cd";
      action = "<cmd>lua vim.diagnostic.open_float()<cr>";
      options.desc = "打开当前行的诊断信息浮窗";
    }
    {
      key = "[d";
      action = "<cmd>lua vim.diagnostic.jump({ count=-1, float=true })<cr>";
      options.desc = "跳转到上一个诊断";
    }
    {
      key = "]d";
      action = "<cmd>lua vim.diagnostic.jump({ count=1, float=true })<cr>";
      options.desc = "跳转到下一个诊断";
    }
    {
      key = "<leader>cR";
      action = "<cmd>lua vim.lsp.buf.rename()<cr>";
      options.desc = "重命名符号";
    }
    {
      key = "<leader>ca";
      action = "<cmd>lua vim.lsp.buf.code_action()<cr>";
      options.desc = "代码操作";
    }
    {
      key = "gD";
      action = "<cmd>lua vim.lsp.buf.declaration()<cr>";
      options.desc = "跳转到声明";
    }
    {
      key = "gd";
      action = "<cmd>lua vim.lsp.buf.definition()<cr>";
      options.desc = "转到定义";
    }
    {
      key = "gi";
      action = "<cmd>lua vim.lsp.buf.implementation()<cr>";
      options.desc = "查找实现";
    }
    {
      key = "gr";
      action = "<cmd>lua vim.lsp.buf.references()<cr>";
      options.desc = "查找引用";
    }
    {
      key = "gt";
      action = "<cmd>lua vim.lsp.buf.type_definition()<cr>";
      options.desc = "跳转到类型定义";
    }
  ];

  # 这里是诊断设置，可根据需要更改为虚拟行显示
  # 这里对诊断进行懒加载
  extraConfigLua = ''
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function()
        local _border = "rounded"
        vim.diagnostic.config({
          -- virtual_lines = true, -- 诊断提示虚拟行
          virtual_text = true, -- 诊断提示内行提示

          signs = {
            active = true,
              text = {
                [vim.diagnostic.severity.ERROR] = "";
                [vim.diagnostic.severity.WARN] = "",
                [vim.diagnostic.severity.INFO] = "",
                [vim.diagnostic.severity.HINT] = "💡",
              },
            },
            update_in_insert = true,
            -- update_in_insert = false,
            underline = true,
            severity_sort = true,
            float = {
              border = _border,
            },
          })
        end,
      })
  '';
}
