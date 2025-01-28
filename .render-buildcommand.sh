#!/bin/bash
# Set environment variables
export SHELL=/bin/bash
export PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD=1
export CYPRESS_INSTALL_BINARY=0
export NODE_OPTIONS="--max_old_space_size=4096"
export PNPM_HOME="/opt/render/project/node_modules/.bin"
export PATH="$PNPM_HOME:$PATH"

# Install global dependencies
npm install -g pnpm@9.15.1 turbo rimraf vite

# Install Vue dependencies directly in design-system
cd packages/design-system
npm install @vitejs/plugin-vue@4.5.2 @vue/compiler-sfc vue --save-dev
cd ../..

# Install project dependencies
pnpm install --no-frozen-lockfile

# Build the project
pnpm build
