#!/usr/bin/env bash
set -euo pipefail
IMAGE=kivy/buildozer
echo "[*] Pull image ${IMAGE}…"
docker pull ${IMAGE}
echo "[*] Building APK (debug)…"
docker run --rm -v "$PWD":/home/user/app -w /home/user/app ${IMAGE} buildozer android debug
echo
echo "[*] Done. APK should be in ./bin/"
ls -al bin || true
