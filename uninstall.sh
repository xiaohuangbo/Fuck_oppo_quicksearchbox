#!/system/bin/sh

# 卸载脚本
MODULE_NAME="Freeze QuickSearchBox Clone"
PACKAGE_NAME="com.heytap.quicksearchbox"
CLONE_USER_ID=999

ui_print " "
ui_print "*******************************"
ui_print "  卸载 $MODULE_NAME"
ui_print "*******************************"
ui_print " "

ui_print "选项"
ui_print "解冻分身应用中"
ui_print "删除分身应用..."

# 默认选择删除分身应用
ui_print "选择删除分身应用..."

# 先解冻应用（如果被冻结）
ui_print "解冻分身应用..."
pm enable --user $CLONE_USER_ID $PACKAGE_NAME 2>/dev/null
pm unhide --user $CLONE_USER_ID $PACKAGE_NAME 2>/dev/null

# 删除分身应用
ui_print "删除分身应用..."
pm uninstall --user $CLONE_USER_ID $PACKAGE_NAME

if [ $? -eq 0 ]; then
    ui_print "✓ 分身应用删除成功"
else
    ui_print "⚠ 分身应用删除失败，可能已不存在"
fi

ui_print " "
ui_print "*******************************"
ui_print "  模块卸载完成!"
ui_print "*******************************"
ui_print " "