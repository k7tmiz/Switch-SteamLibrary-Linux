#!/bin/bash
STEAM_DIR="$HOME/.steam/steam/steamapps"
SHARED_DIR="/run/media/Bruno/DATA/SteamLibrary/steamapps"

# 清理旧目录
rm -rf "$STEAM_DIR/compatdata"

#创建新目录
mkdir -p "$STEAM_DIR/compatdata"

# 创建符号链接
ln -s "$STEAM_DIR/compatdata" "$SHARED_DIR"

# 验证结果
ls -l "$SHARED_DIR/compatdata"
