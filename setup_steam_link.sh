#!/bin/bash
STEAM_DIR="$HOME/.steam/steam/steamapps"
COMPATDATA_DIR="/run/media/Bruno/DATA/SteamLibrary/steamapps/compatdata"

# 清理旧目录
rm -rf "$STEAM_DIR/compatdata"

# 创建符号链接
ln -s "$COMPATDATA_DIR" "$STEAM_DIR/compatdata"

# 验证结果
ls -l "$STEAM_DIR/compatdata"
