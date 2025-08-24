@echo off
set IMAGE=kivy/buildozer
echo [*] Pull image %IMAGE% …
docker pull %IMAGE%
echo [*] Building APK (debug)…
docker run --rm -v "%cd%":/home/user/app -w /home/user/app %IMAGE% buildozer android debug
echo.
echo [*] Done. APK should be in .\bin\
pause
