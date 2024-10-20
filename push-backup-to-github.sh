#!/bin/bash

# Navigate to the ThinBackup directory
cd /var/lib/jenkins/plugins/thinBackup/git-thinbackup

# Initialize Git if not already done
if [ ! -d ".git" ]; then
  git init
  git remote add origin git@github.com:yair232/status-page.git
fi

# Configure Git user for Jenkins
git config --global user.name "rtzi-hub"
git config --global user.email "jenkins@example.com"

# Switch to 'main' branch or create it if it does not exist
git checkout main || git checkout -b main

# Add and commit the backup files
git add .
git commit -m "Jenkins backup on $(date +'%Y-%m-%d')"

# Push backup to the 'main' branch
git push origin main
