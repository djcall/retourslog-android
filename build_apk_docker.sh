#!/usr/bin/env bash
set -e
# Build APK using the official Kivy Buildozer Docker image.
# Requires Docker installed. Run from the project root (where main.py is).
IMAGE=kivy/buildozer
docker pull $IMAGE
docker run --rm -it \
  -e BUILDOZER_WARN_ON_ROOT=0 \
  -v "$PWD":/home/user/app \
  $IMAGE \
  buildozer android debug
echo ""
echo "APK généré dans ./bin/"
