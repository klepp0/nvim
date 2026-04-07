#!/usr/bin/env bats

setup() {
  REPO_DIR="${BATS_TEST_DIRNAME}/.."
  export HOME="$BATS_TMPDIR/home"
  mkdir -p "$HOME"
}

teardown() {
  rm -rf "$HOME"
}

@test "install.sh backs up existing nvim config and links repo" {
  mkdir -p "$HOME/.config/nvim"
  touch "$HOME/.config/nvim/example"

  run bash -c "cd \"$REPO_DIR\" && printf 'y\\n' | HOME=\"$HOME\" ./install.sh"

  [ "$status" -eq 0 ]
  [ -d "$HOME/.config/nvim.bak" ]
  [ -f "$HOME/.config/nvim.bak/example" ]
  [ -L "$HOME/.config/nvim" ]

  run readlink "$HOME/.config/nvim"
  [ "$status" -eq 0 ]
  [ "$output" = "$REPO_DIR" ]
}
