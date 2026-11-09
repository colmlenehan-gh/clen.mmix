#!/usr/bin/env bash
#
# clen.mmix installer
#
# Puts the project at ~/clen.mmix so that, from a freshly opened Terminal
# window (which starts in your home folder), you can simply type:
#
#     clen.mmix/start
#
# Usage:
#   ./install.sh               install or update from this checkout
#   ./install.sh --uninstall   remove ~/clen.mmix
#
# One-line install from GitHub (replace colmlenehan-gh with the account hosting the repo):
#   curl -fsSL https://raw.githubusercontent.com/colmlenehan-gh/clen.mmix/main/install.sh | bash

set -euo pipefail

REPO_URL="${CLEN_REPO_URL:-https://github.com/colmlenehan-gh/clen.mmix.git}"
DEST="$HOME/clen.mmix"

say() { printf '%s\n' "$*"; }
die() { printf 'install: %s\n' "$*" >&2; exit 1; }

if [ "${1:-}" = "--uninstall" ]; then
  if [ -d "$DEST" ]; then
    rm -rf "$DEST"
    say "Removed $DEST"
  else
    say "Nothing to remove at $DEST"
  fi
  exit 0
fi

# Where is this script running from? Empty when piped through curl | bash.
here=""
if [ -n "${BASH_SOURCE[0]:-}" ] && [ -f "${BASH_SOURCE[0]}" ]; then
  here="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
fi

if [ -n "$here" ] && [ -f "$here/start" ] && [ -d "$here/scenes" ]; then
  if [ "$here" = "$DEST" ]; then
    say "Already located at $DEST, refreshing permissions."
  else
    say "Installing from $here to $DEST"
    rm -rf "$DEST"
    mkdir -p "$DEST"
    cp -R "$here/start" "$here/scenes" "$here/README.md" "$here/LICENSE" "$here/install.sh" "$DEST/"
  fi
else
  command -v git >/dev/null 2>&1 || die "git is required (on a Mac, run: xcode-select --install)"
  if [ -d "$DEST/.git" ]; then
    say "Updating existing install at $DEST"
    git -C "$DEST" pull --ff-only
  else
    [ -e "$DEST" ] && die "$DEST already exists and is not a git checkout. Move it away first."
    say "Cloning $REPO_URL to $DEST"
    git clone --depth 1 "$REPO_URL" "$DEST"
  fi
fi

chmod +x "$DEST/start" "$DEST/install.sh"

# Files fetched as a ZIP in a browser carry a quarantine flag on macOS.
if [ "$(uname -s)" = "Darwin" ]; then
  xattr -dr com.apple.quarantine "$DEST" 2>/dev/null || true
fi

say ""
say "Installed."
say "Open a new Terminal window and run:"
say ""
say "    clen.mmix/start"
say ""
say "(Terminal opens in your home folder, which is where that path resolves.)"
