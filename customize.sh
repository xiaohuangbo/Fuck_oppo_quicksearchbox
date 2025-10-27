#!/system/bin/sh

# 模块信息
MODULE_NAME="Fuck Oppo QuickSearchBox Clone"
MODULE_VERSION="1.0"
PACKAGE_NAME="com.heytap.quicksearchbox"
CLONE_USER_ID=999  # MultiApp分区的用户ID

ui_print " "
ui_print "*******************************"
ui_print "  $MODULE_NAME v$MODULE_VERSION"
ui_print "*******************************"
ui_print " "

# 检查root权限
if [ "$(id -u)" -ne 0 ]; then
    ui_print "错误: 需要root权限"
    exit 1
fi

# 检查pm命令可用性
if ! command -v pm > /dev/null; then
    ui_print "错误: pm命令不可用"
    exit 1
fi

ui_print "步骤1: 检查原始应用是否存在"
if pm list packages | grep -q "$PACKAGE_NAME"; then
    ui_print "✓ 找到原始应用: $PACKAGE_NAME"
else
    ui_print "✗ 未找到原始应用: $PACKAGE_NAME"
    exit 1
fi

ui_print " "
ui_print "步骤2: 创建分身到MultiApp分区"
ui_print "正在为 $PACKAGE_NAME 创建分身..."

# 使用pm create-user创建多开用户（如果不存在）
if ! pm list users | grep -q "MultiApp"; then
    ui_print "创建MultiApp用户..."
    pm create-user --profileOf 0 --managed MultiApp
    sleep 2
fi

# 安装应用到分身用户
ui_print "安装应用到分身用户..."
pm install-existing --user $CLONE_USER_ID $PACKAGE_NAME

if [ $? -eq 0 ]; then
    ui_print "✓ 分身应用安装成功"
else
    ui_print "✗ 分身应用安装失败"
    exit 1
fi

ui_print " "
ui_print "步骤3: 冻结分身应用"
ui_print "正在冻结分身应用..."

# 冻结分身应用
pm disable --user $CLONE_USER_ID $PACKAGE_NAME

if [ $? -eq 0 ]; then
    ui_print "✓ 分身应用冻结成功"
else
    ui_print "✗ 分身应用冻结失败"
    # 尝试使用其他方法
    ui_print "尝试使用其他方法冻结..."
    pm hide --user $CLONE_USER_ID $PACKAGE_NAME
    if [ $? -eq 0 ]; then
        ui_print "✓ 使用hide方法冻结成功"
    else
        ui_print "✗ 所有冻结方法都失败"
        exit 1
    fi
fi

ui_print " "
ui_print "步骤4: 验证冻结状态"
ui_print "检查分身应用状态..."

# 检查应用状态
APP_STATE=$(pm list packages -d --user $CLONE_USER_ID | grep "$PACKAGE_NAME")
if [ -n "$APP_STATE" ]; then
    ui_print "✓ 分身应用已成功冻结 (禁用状态)"
else
    ui_print "⚠ 分身应用可能未完全冻结，但安装已完成"
fi

ui_print " "
ui_print "*******************************"
ui_print "  模块安装完成!"
ui_print "  $PACKAGE_NAME 分身已创建并冻结"
ui_print "  用户ID: $CLONE_USER_ID (MultiApp)"
ui_print "FUCK♂YOU OPPO 全局搜索 "
ui_print "*******************************"
ui_print " "