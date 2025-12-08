#!/bin/bash
IMAGE_NAME="$1"
K8S_DEPLOYMENT_FILE="k8s/deployment.yml"

git config user.name "github-actions[bot]"
git config user.email "github-actions[bot]@users.noreply.github.com"

# Обновляем image в deployment.yml
sed -i "s|image:.*|image: ${IMAGE_NAME}|g" ${K8S_DEPLOYMENT_FILE}

# Добавляем и коммитим изменения
git add ${K8S_DEPLOYMENT_FILE}

if git diff --staged --quiet; then
  echo "No changes to commit."
else
  git commit -m "Update Kubernetes image to ${IMAGE_NAME}"
  # Для отправки коммита, нужно настроить Git credentials в GitHub Actions (например, PAT)
  git push origin main
fi
