# Nix Darwin System Configuration

这个仓库包含了我的 macOS 系统配置，使用 nix-darwin 和 GNU stow 来管理。

## 前置要求

- 安装 Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## 配置说明

本项目使用 GNU Stow 管理 dotfiles，所有配置文件都会被软链接到用户家目录。所需的工具（如 stow、alacritty、tmux 等）都会通过 nix-darwin 自动安装。

### 安装步骤

```bash
brew bundle --file=Brewfile
```

### Alacritty 配置

Alacritty 的配置文件位于 `.config/alacritty` 目录下：

```
dotfiles/
├── .config/
│   ├── alacritty/
│   │   └── alacritty.yml         # Alacritty 配置文件
│   └── ...
└── ... 其他配置文件
```

### Tmux 配置

本项目使用 [Oh My Tmux](https://github.com/gpakosz/.tmux) 作为基础配置。配置文件组织如下：

```
dotfiles/
├── .tmux/                          # Oh My Tmux 子模块
├── .config/
│   └── tmux/
│       ├── tmux.conf              # 符号链接到 .tmux/.tmux.conf
│       └── tmux.conf.local        # 本地自定义配置
└── ... 其他配置文件
```

#### 安装步骤

1. 克隆仓库到家目录：
```bash
git clone <repository-url> ~/.dotfiles
cd ~/.dotfiles
```

2. 初始化并更新子模块：
```bash
git submodule update --init --recursive
```

3. 创建必要的符号链接：
```bash
# 确保目标目录存在
mkdir -p .config/tmux

# 创建从 .config/tmux/tmux.conf 到 .tmux/.tmux.conf 的相对符号链接
ln -s .tmux/.tmux.conf .config/tmux/tmux.conf
```

4. 使用 stow 创建配置文件的符号链接：
```bash
stow .
```

这将会在家目录中创建如下结构：
```
~/
├── .config/
│   └── tmux/
│       ├── tmux.conf              # 最终指向 ~/.tmux/.tmux.conf
│       └── tmux.conf.local        # 本地自定义配置
└── .tmux/                         # Oh My Tmux 仓库
```

# font 安装

- maple-font
- ComicShannsMono Nerd Font

```
https://github.com/subframe7536/maple-font/releases
https://www.nerdfonts.com/font-downloads
```

```bash
brew install --cask font-maple-mono-nf
brew install --cask font-comic-shanns-mono-nerd-font
```

