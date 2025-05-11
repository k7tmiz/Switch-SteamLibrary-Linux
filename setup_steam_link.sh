#!/bin/bash
set -euo pipefail  # 启用严格模式：遇到错误立即退出，未定义变量报错

STEAM_DIR="$HOME/.steam/steam/steamapps"
SHARED_DIR="/run/media/Bruno/DATA/SteamLibrary/steamapps"

# 添加执行状态反馈
echo "▶ 开始处理 Steam 兼容数据目录迁移..."

# 清理旧目录（增加存在性检查）
if [ -d "$STEAM_DIR/compatdata" ]; then
    echo "▷ 清理旧目录: $STEAM_DIR/compatdata"
    rm -rf "$STEAM_DIR/compatdata"
    echo "✔ 旧目录清理完成"
else
    echo "▷ 无需清理：目录不存在 $STEAM_DIR/compatdata"
fi

# 创建新目录（增强错误处理）
echo "▷ 创建新目录: $STEAM_DIR/compatdata"
mkdir -p "$STEAM_DIR/compatdata" || {
    echo "✘ 目录创建失败"
    exit 1
}
echo "✔ 新目录创建成功"

# 创建符号链接（增加覆盖确认）
echo "▷ 正在创建符号链接..."
if [ -e "$SHARED_DIR/compatdata" ]; then
    echo "⚠ 检测到已存在的链接/目录：$SHARED_DIR/compatdata"
    echo "▷ 执行强制覆盖..."
fi
ln -sfn "$STEAM_DIR/compatdata" "$SHARED_DIR/compatdata" || {
    echo "✘ 符号链接创建失败"
    exit 1
}
echo "✔ 符号链接已更新"

# 增强版验证结果
echo -e "\n▷ 最终验证："
if [ "$(readlink -f "$SHARED_DIR/compatdata")" = "$(realpath "$STEAM_DIR/compatdata")" ]; then
    echo "✅ 验证通过：符号链接指向正确"
    ls -ld "$SHARED_DIR/compatdata"
else
    echo "❌ 验证失败：符号链接指向异常"
    exit 1
fi

echo -e "\n🎉 所有操作已完成"
