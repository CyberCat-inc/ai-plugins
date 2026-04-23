#!/usr/bin/env bash
# Universal local installer for the cybercat marketplace + plugin.
# Works for ANY user, from ANY clone location. No hardcoded paths.
#
# Usage:
#   ./install-local.sh            # install for Cursor + Claude Code (if available)
#   ./install-local.sh --cursor   # Cursor only
#   ./install-local.sh --claude   # Claude Code only
#   ./install-local.sh --uninstall

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MARKETPLACE_NAME="cybercat"
PLUGIN_NAME="cybercat"
PLUGIN_DIR="$REPO_ROOT/plugins/$PLUGIN_NAME"

mode="${1:-all}"

info() { printf '  %s\n' "$*"; }
ok()   { printf '  \033[32m✓\033[0m %s\n' "$*"; }
warn() { printf '  \033[33m!\033[0m %s\n' "$*"; }
err()  { printf '  \033[31m✗\033[0m %s\n' "$*" >&2; }

install_cursor() {
  printf '\n\033[1mCursor\033[0m\n'

  local target_parent="$HOME/.cursor/plugins/local"
  local link_path="$target_parent/$PLUGIN_NAME"

  mkdir -p "$target_parent"

  if [[ -L "$link_path" ]]; then
    info "replacing existing symlink"
    rm "$link_path"
  elif [[ -e "$link_path" ]]; then
    err "$link_path exists and is not a symlink — remove it manually, then re-run"
    return 1
  fi

  ln -s "$PLUGIN_DIR" "$link_path"
  ok "linked $link_path → $PLUGIN_DIR"
  info "reload Cursor (Cmd+Shift+P → 'Developer: Reload Window')"
}

install_claude() {
  printf '\n\033[1mClaude Code\033[0m\n'

  if ! command -v claude >/dev/null 2>&1; then
    warn "'claude' CLI not found — skipping. Install it, then run this script again with --claude."
    info "Manual install inside Claude Code:"
    info "  /plugin marketplace add $REPO_ROOT"
    info "  /plugin install ${PLUGIN_NAME}@${MARKETPLACE_NAME}"
    return 0
  fi

  if claude plugin marketplace list 2>/dev/null | grep -q "^${MARKETPLACE_NAME}\b"; then
    info "marketplace '$MARKETPLACE_NAME' already registered — updating"
    claude plugin marketplace update "$MARKETPLACE_NAME" >/dev/null
  else
    claude plugin marketplace add "$REPO_ROOT" >/dev/null
    ok "added marketplace '$MARKETPLACE_NAME' from $REPO_ROOT"
  fi

  if claude plugin list 2>/dev/null | grep -q "^${PLUGIN_NAME}\b"; then
    info "plugin '$PLUGIN_NAME' already installed"
  else
    claude plugin install "${PLUGIN_NAME}@${MARKETPLACE_NAME}" >/dev/null
    ok "installed $PLUGIN_NAME@$MARKETPLACE_NAME"
  fi
}

uninstall() {
  printf '\n\033[1mUninstall\033[0m\n'

  local link_path="$HOME/.cursor/plugins/local/$PLUGIN_NAME"
  if [[ -L "$link_path" ]]; then
    rm "$link_path" && ok "removed Cursor symlink $link_path"
  else
    info "no Cursor symlink to remove"
  fi

  if command -v claude >/dev/null 2>&1; then
    claude plugin uninstall "${PLUGIN_NAME}@${MARKETPLACE_NAME}" 2>/dev/null \
      && ok "uninstalled Claude Code plugin" \
      || info "no Claude Code plugin to uninstall"
    claude plugin marketplace remove "$MARKETPLACE_NAME" 2>/dev/null \
      && ok "removed Claude Code marketplace" \
      || info "no Claude Code marketplace to remove"
  fi
}

printf "cybercat plugin installer\n"
printf "  repo: %s\n" "$REPO_ROOT"

case "$mode" in
  all)        install_cursor; install_claude ;;
  --cursor)   install_cursor ;;
  --claude)   install_claude ;;
  --uninstall) uninstall ;;
  -h|--help)
    grep '^#' "$0" | sed 's/^# \{0,1\}//'
    exit 0 ;;
  *)
    err "unknown option: $mode (use --cursor | --claude | --uninstall | --help)"
    exit 2 ;;
esac

printf '\nDone. Try: \033[1m/code-review\033[0m in Cursor or Claude Code.\n'
