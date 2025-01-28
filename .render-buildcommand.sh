#!/bin/bash
# .render-buildcommand.sh (updated version)

# 1. SSH Setup (Critical Fix)
# ---------------------------
mkdir -p ~/.ssh
# Render uses base64-encoded env vars without newlines by default:
echo "$SSH_PRIVATE_KEY" | base64 -di > ~/.ssh/id_ed25519  # -di handles binary decode
chmod 600 ~/.ssh/id_ed25519

# Configure SSH client properly:
cat <<EOF > ~/.ssh/config
Host github.com
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519
  StrictHostKeyChecking no
EOF

# 2. Environment Setup
# --------------------
export NODE_VERSION=20.10.0  # Explicitly set for Render
export PNPM_HOME="/opt/render/project/node_modules/.bin"
export PATH="$PNPM_HOME:$PATH"
export NODE_OPTIONS="--max_old_space_size=4096"

# 3. Dependency Installation
# --------------------------
# Clean installation for monorepos:
rm -rf node_modules
npm install -g pnpm@9.15.1
pnpm install --frozen-lockfile  # Safer than --no-frozen-lockfile

# 4. Design-System Specific Fixes
# -------------------------------
cd packages/design-system
pnpm add -D @vitejs/plugin-vue@4.5.2 @vue/compiler-sfc vue@3.4.21
cd ../..

# 5. Build Process
# ----------------
pnpm run build
