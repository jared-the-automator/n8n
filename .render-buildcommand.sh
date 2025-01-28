#!/bin/bash
npm install -g pnpm turbo rimraf vite
pnpm install --no-frozen-lockfile
pnpm build
