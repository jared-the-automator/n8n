#!/bin/bash
# Install global dependencies
npm install -g pnpm turbo rimraf vite

# Install project dependencies
pnpm install --no-frozen-lockfile

# Install Vue dependencies specifically for design-system
cd packages/design-system
pnpm add -D @vitejs/plugin-vue @vue/compiler-sfc vue
cd ../..

# Build the project
pnpm build
