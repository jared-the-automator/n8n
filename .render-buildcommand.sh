#!/bin/bash
# Install global dependencies
npm install -g pnpm turbo rimraf vite

# Pre-install Vue dependencies globally to ensure they're available
pnpm setup
pnpm add -g @vitejs/plugin-vue@4.5.2 @vue/compiler-sfc vue

# Install project dependencies with Vue packages
export PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD=1
export CYPRESS_INSTALL_BINARY=0
export NODE_OPTIONS="--max_old_space_size=4096"

# Main install
pnpm install --no-frozen-lockfile

# Ensure Vue dependencies are in design-system
cd packages/design-system
pnpm install @vitejs/plugin-vue@4.5.2 @vue/compiler-sfc vue --save-dev
cd ../..

# Build the project
pnpm build
