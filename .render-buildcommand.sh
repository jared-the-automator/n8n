#!/bin/bash
# Install global dependencies
npm install -g pnpm turbo rimraf vite @vitejs/plugin-vue

# Install project dependencies
pnpm install --no-frozen-lockfile

# Install Vue-specific dependencies
pnpm add -D @vitejs/plugin-vue @vue/compiler-sfc vue

# Build the project
pnpm build
