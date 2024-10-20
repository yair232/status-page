#!/bin/bash

# Define the backup path and destination in the GitHub repo
BACKUP_DIR="/var/lib/jenkins/plugins/thinBackup/git-push-backup"
DEST_DIR="/var/lib/jenkins/plugins/thinBackup/final-project-terraform/Jenkins/backups"

# Navigate to the backup directory
cd $BACKUP_DIR

# Initialize Git if it's not already a repo
if [ ! -d ".git" ]; then
  git init
  git remote add origin git@github.com:yair232/status-page.git
fi

# Configure Git for Jenkins user
git config --global user.name "rtzi-hub"
git config --global user.email "jenkins@example.com"

# Stage, commit, and push backup files to GitHub
git add .
git commit -m "Jenkins backup on $(date +'%Y-%m-%d')"
git pull origin main --rebase  # Pull latest changes in case there are conflicts
git push origin main
