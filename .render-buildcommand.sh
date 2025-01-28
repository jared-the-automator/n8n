#!/bin/bash
npm install -g pnpm turbo rimraf
pnpm install --no-frozen-lockfile
pnpm add https://github.com/jared-the-automator/n8n-nodes-job-info/archive/main.tar.gz --workspace-root
pnpm build
