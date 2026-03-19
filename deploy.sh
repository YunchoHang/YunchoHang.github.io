#!/bin/bash

# 1️⃣ Build Hugo site
hugo

# 2️⃣ Add all changes in the root repo
git add -A

# 3️⃣ Commit with timestamp
git commit -m "Update site and source $(date +'%Y-%m-%d %H:%M:%S')"

# 4️⃣ Push to main branch
git push origin main

echo "✅ Full project deployment complete!"

