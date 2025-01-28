# Create the build command file
@'
#!/bin/bash
npm install --no-workspace
npm run build
'@ | Out-File -FilePath ".render-buildcommand.sh" -Encoding UTF8
