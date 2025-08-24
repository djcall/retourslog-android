[app]
title = Retour Slog Android
package.name = retourslog
package.domain = com.cedricgazda
source.dir = .
source.include_exts = py,png,jpg,jpeg,kv,atlas
version = 0.1
requirements = python3,kivy,pillow,openpyxl,plyer
orientation = portrait
fullscreen = 0
android.api = 33
android.minapi = 21
android.archs = arm64-v8a,armeabi-v7a
android.permissions = READ_EXTERNAL_STORAGE,WRITE_EXTERNAL_STORAGE
# If you hit file access issues on Android 11+, consider enabling scoped storage settings or using androidstorage4kivy.

[buildozer]
log_level = 1
warn_on_root = 0
