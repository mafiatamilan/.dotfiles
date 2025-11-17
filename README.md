# 🏠 Dotfiles

Personal configuration files for my development environment. These dotfiles help me quickly set up and maintain a consistent development workflow across different machines.

## 📁 What's Included

This repository contains configuration files for:

- **Shell Configuration**: Bash/Zsh profiles, aliases, and functions
- **Git Configuration**: Global git settings and aliases
- **Editor Configuration**: Vim/Neovim, VS Code settings
- **Terminal Configuration**: Terminal emulator preferences
- **Development Tools**: Various CLI tool configurations
- **System Preferences**: macOS/Linux system settings

## 🚀 Quick Start

### Prerequisites

- Git
- Bash or Zsh shell
- Basic command line knowledge

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/mafiatamilan/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

2. **Run the installation script**
   ```bash
   ./install.sh
   ```

   Or manually symlink the files you want:
   ```bash
   ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
   ln -sf ~/dotfiles/.vimrc ~/.vimrc
   # Add more as needed
   ```

3. **Reload your shell**
   ```bash
   source ~/.bashrc
   # or
   source ~/.zshrc
   ```

## 📂 Repository Structure

```
dotfiles/
├── modules/           # Modular configuration files
├── home.nix          # Nix configuration (if using Nix)
├── README.md         # This file
├── install.sh        # Installation script (to be created)
└── .gitconfig        # Git configuration (example)
```

## ⚙️ Configuration Highlights

### Shell Aliases
- `ll` - Enhanced directory listing
- `la` - Show hidden files
- `..` - Go up one directory
- `...` - Go up two directories

### Git Configuration
- Useful aliases for common git operations
- Better diff and merge tools
- Consistent commit formatting

### Editor Setup
- Syntax highlighting
- Custom key bindings
- Plugin configurations

## 🛠️ Customization

Feel free to fork this repository and customize it for your needs:

1. **Fork the repository** on GitHub
2. **Clone your fork** locally
3. **Modify configurations** to match your preferences
4. **Test thoroughly** before committing changes
5. **Keep your fork updated** with upstream changes

## 📱 Platform Support

- ✅ macOS
- ✅ Linux (Ubuntu/Debian)
- ✅ Linux (Arch/Manjaro)
- ⚠️ Windows (WSL recommended)

## 🔧 Manual Setup Steps

Some configurations may require manual setup:

1. **Install required software packages**
2. **Set up SSH keys** for GitHub
3. **Configure terminal themes** and fonts
4. **Import browser bookmarks** and extensions
5. **Set up development environment** specifics

## 📚 Useful Resources

- [Dotfiles Guide](https://dotfiles.github.io/)
- [Awesome Dotfiles](https://github.com/webpro/awesome-dotfiles)
- [GitHub's Dotfiles](https://dotfiles.github.io/)

## 🤝 Contributing

If you have suggestions for improvements:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Inspired by various dotfiles repositories in the community
- Thanks to the open source tools that make this possible
- Special thanks to contributors and users who provide feedback

## 📞 Contact

- GitHub: [@mafiatamilan](https://github.com/mafiatamilan)
- Issues: [GitHub Issues](https://github.com/mafiatamilan/dotfiles/issues)

---

*Happy coding! 🚀*
