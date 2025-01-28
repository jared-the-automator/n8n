#!/bin/bash
npm install -g pnpm
pnpm install --no-frozen-lockfile
pnpm add github:jared-the-automator/n8n-nodes-job-info --workspace
pnpm build
