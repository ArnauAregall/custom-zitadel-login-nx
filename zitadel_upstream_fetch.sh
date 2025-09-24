#!/bin/bash

# ================================
# Configurable variables
# ================================
UPSTREAM_REPO="https://github.com/zitadel/zitadel.git"
UPSTREAM_BRANCH="remove-turbo-2"
TMP_DIR=".artifacts/tmp_upstream_zitadel_$UPSTREAM_BRANCH"

# ================================
# Utility functions
# ================================

# Ensure a directory exists, create if not
ensure_dir() {
  local dir="$1"
  if [ ! -d "$dir" ]; then
    mkdir -p "$dir"
    echo "Created '$dir/' directory."
  else
    echo "'$dir/' directory already exists."
  fi
}

# Add a directory to .gitignore if missing
ensure_gitignore_entry() {
  local dir="$1/"
  if ! grep -qxF "$dir" .gitignore 2>/dev/null; then
    echo "$dir" >> .gitignore
    echo "Added '$dir' to .gitignore."
  else
    echo "'$dir' already listed in .gitignore."
  fi
}

# Clone upstream into temp dir
clone_upstream() {
  rm -rf "$TMP_DIR"
  git clone --depth 1 --branch "$UPSTREAM_BRANCH" "$UPSTREAM_REPO" "$TMP_DIR"
}

# Sync a directory from upstream
sync_from_upstream() {
  local upstream_subdir="$1"
  local target_dir="$2"

  echo "Fetching '$target_dir/' from upstream..."

  ensure_dir "$target_dir"
  ensure_gitignore_entry "$target_dir"

  rsync -a \
    --exclude '.git' \
    "$TMP_DIR/$upstream_subdir/" "$target_dir/"

  echo "✅ '$target_dir/' updated from upstream and gitignored"
}

# Clean temp dir only
clean_tmp() {
  if [ -d "$TMP_DIR" ]; then
    rm -rf "$TMP_DIR"
    echo "🧹 Removed temporary directory '$TMP_DIR'."
  fi
}

# Clean everything (tmp + synced dirs)
clean_all() {
  for dir in "$TMP_DIR" "proto" "packages"; do
    if [ -d "$dir" ]; then
      rm -rf "$dir"
      echo "🧹 Removed '$dir/'."
    fi
  done
}

# ================================
# Main entrypoint
# ================================
case "$1" in
  proto)
    clone_upstream
    sync_from_upstream "proto" "proto"
    clean_tmp
    ;;
  packages)
    clone_upstream
    sync_from_upstream "packages" "packages"
    clean_tmp
    ;;
  all)
    clone_upstream
    sync_from_upstream "proto" "proto"
    sync_from_upstream "packages" "packages"
    clean_tmp
    ;;
  clean)
    clean_all
    ;;
  *)
    echo "Usage: $0 {proto|packages|all|clean}"
    exit 1
    ;;
esac