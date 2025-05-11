#!/bin/bash
# Steam默认安装目录
STEAM_DIR="$HOME/.steam/steam/steamapps"

# 共享存储位置（请根据实际挂载点修改）
SHARED_DIR="/run/media/Bruno/DATA/SteamLibrary/steamapps"

# 确保共享目录存在
if [ ! -d "$SHARED_DIR" ]; then
    echo "错误：共享目录不存在 $SHARED_DIR"
    exit 1
fi

# 备份原目录（安全防护）
if [ -d "$STEAM_DIR/compatdata" ]; then
    echo "正在备份原有 compatdata 目录..."
    mv "$STEAM_DIR/compatdata" "$STEAM_DIR/compatdata.bak.$(date +%s)"
fi

# 创建协调目录结构
echo "创建共享 compatdata 目录..."
mkdir -p "$SHARED_DIR/compatdata"

# 创建符号链接（关键修改：链接方向调换）
echo "创建符号链接..."
ln -svf "$SHARED_DIR/compatdata" "$STEAM_DIR/compatdata"

# 增强验证（带颜色提示）
echo -e "\n验证结果："
if [ -L "$STEAM_DIR/compatdata" ]; then
    ls -l --color=auto "$STEAM_DIR/compatdata"
    echo -e "\n\033[32m✓ 符号链接创建成功\033[0m"
    echo "实际存储路径：$SHARED_DIR/compatdata"
else
    echo -e "\033[31m✗ 符号链接创建失败\033[0m"
    exit 1
fi
