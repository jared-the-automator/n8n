#!/bin/bash
# Set up SSH with multiple keys
mkdir -p ~/.ssh

# Add first key (for n8n-nodes-job-info) - with explicit newlines
echo "-----BEGIN OPENSSH PRIVATE KEY-----
$SSH_PRIVATE_KEY
-----END OPENSSH PRIVATE KEY-----" > ~/.ssh/id_ed25519

# Add second key (for n8n)
echo "-----BEGIN OPENSSH PRIVATE KEY-----
$SSH_PRIVATE_KEY1
-----END OPENSSH PRIVATE KEY-----" > ~/.ssh/id_ed25519_1

chmod 600 ~/.ssh/id_ed25519
chmod 600 ~/.ssh/id_ed25519_1

# Create SSH config
cat > ~/.ssh/config << EOF
Host github.com-1
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519
    IdentitiesOnly yes

Host github.com-2
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519_1
    IdentitiesOnly yes
EOF

chmod 600 ~/.ssh/config

# Start SSH agent and add keys
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
ssh-add ~/.ssh/id_ed25519_1

# Add GitHub to known hosts
ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts

# Configure git
git config --global url."git@github.com-1:jared-the-automator/n8n-nodes-job-info".insteadOf "git+ssh://git@github.com/jared-the-automator/n8n-nodes-job-info"
git config --global url."git@github.com-2:jared-the-automator/n8n".insteadOf "git+ssh://git@github.com/jared-the-automator/n8n"

# Set environment variables
export SHELL=/bin/bash
export PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD=1
export CYPRESS_INSTALL_BINARY=0
export NODE_OPTIONS="--max_old_space_size=4096"

# Install global dependencies
npm install -g pnpm@9.15.1 turbo rimraf vite

# Install Vue dependencies globally first
npm install -g @vitejs/plugin-vue@4.5.2 @vue/compiler-sfc vue

# Install project dependencies
pnpm install --no-frozen-lockfile

# Install Vue dependencies in design-system
cd packages/design-system
pnpm add -D @vitejs/plugin-vue@4.5.2 @vue/compiler-sfc vue
pnpm install
cd ../..

# Build the project
pnpm build
