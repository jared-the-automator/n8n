# Create the file with proper Unix line endings
@'
#!/bin/bash
npm install --no-workspace
npm run build
'@ | Set-Content -Path ".render-buildcommand.sh" -NoNewline -Encoding UTF8

# Ensure the file has Unix line endings
((Get-Content ".render-buildcommand.sh") -join "`n") + "`n" | Set-Content -NoNewline -Path ".render-buildcommand.sh"
