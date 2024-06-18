# `nvim` 🪬

<div align="center">
![Latest Version](https://img.shields.io/github/v/tag/klepp0/nvim?label=latest%20version)
![Releases](https://github.com/sacklippe/nvim/actions/workflows/release.yml/badge.svg)
![Dispatch](https://github.com/sacklippe/nvim/actions/workflows/dispatch.yml/badge.svg)

</div>

Welcome to my magical `nvim` setup! 🧙‍♂️✨

## Setup

This module is now embedded into my [dotfiles](https://github.com/klepp0/dotfiles). You can use the installation process in there to setup your `nvim` configs. 🪬

### Installation

To set up the `nvim` configuration you can use the `install.sh` script:

```shell
git clone https://github.com/klepp0/nvim.git
make install
```

The script will back up your existing `~/.config/nvim` directory as `~/.config/nvim.bak` before it links the nvim folder of the cloned repository to the location of your previous configurations.

### Uninstallation

Should you wish to return to the dark ages and remove these delightful `nvim` configurations, run the `uninstall.sh` script:

```shell
make uninstall
```

This will remove the symlinks and restore your original files from the backup directory.

### Telescope 🔭

To unlock the full potential of Telescope and see the stars (or just find your files), you’ll need these mystical artifacts:

- [ripgrep](https://github.com/BurntSushi/ripgrep): The legendary search tool forged in the fires of Mount Code.
- [fd](https://github.com/sharkdp/fd): The swift and nimble finder, blessed by the gods of efficiency.

Install these, and you'll be navigating your code like a wizard in no time!
