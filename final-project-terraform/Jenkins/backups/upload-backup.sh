#!/bin/bash

# Define the backup source path and destination path in the GitHub repo
BACKUP_SOURCE_DIR="/var/lib/jenkins/plugins/thinBackup/git-push-backup"
DEST_DIR="/var/lib/jenkins/plugins/thinBackup/final-project-terraform/Jenkins/backups"

# Navigate to the local GitHub repository
cd /var/lib/jenkins/plugins/thinBackup/git-push-backup

# Ensure that the destination directory exists in the repo
mkdir -p final-project-terraform/Jenkins/backups

# Copy the backup files to the desired destination path in the repo
cp -r $BACKUP_SOURCE_DIR/* final-project-terraform/Jenkins/backups/

# Initialize Git if it's not already a repo
if [ ! -d ".git" ]; then
  git init
  git remote add origin git@github.com:yair232/status-page.git
fi

# Ensure you are on the main branch
git checkout main || git checkout -b main  # Switch to main branch or create it

# Configure Git for Jenkins user
git config --global user.name "rtzi-hub"
git config --global user.email "jenkins@example.com"

# Stage, commit, and push backup files to the correct path in GitHub
git add final-project-terraform/Jenkins/backups/
git commit -m "Jenkins backup on $(date +'%Y-%m-%d')"
git pull origin main --rebase  # Pull latest changes in case there are conflicts
git push origin main
