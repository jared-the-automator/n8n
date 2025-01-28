#!/bin/bash
npm install -g pnpm turbo
pnpm install --no-frozen-lockfile
pnpm add https://github.com/jared-the-automator/n8n-nodes-job-info.git --workspace-root
pnpm build
