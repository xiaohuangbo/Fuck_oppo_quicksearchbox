#!/system/bin/sh

# 服务脚本 - 在启动时确保分身应用保持冻结状态
MODULE_DIR="/data/adb/modules/freeze_quicksearchbox_clone"
PACKAGE_NAME="com.heytap.quicksearchbox"
CLONE_USER_ID=999

# 等待系统完全启动
while [ "$(getprop sys.boot_completed)" != "1" ]; do
    sleep 5
done

# 额外等待应用服务就绪
sleep 10

# 检查分身应用状态并确保冻结
check_and_freeze() {
    # 检查分身应用是否处于启用状态
    ENABLED_APPS=$(pm list packages -e --user $CLONE_USER_ID 2>/dev/null | grep "$PACKAGE_NAME")
    
    if [ -n "$ENABLED_APPS" ]; then
        # 应用处于启用状态，需要冻结
        log -p i -t "FreezeQuickSearchClone" "检测到分身应用处于启用状态，正在冻结..."
        pm disable --user $CLONE_USER_ID $PACKAGE_NAME
        
        if [ $? -eq 0 ]; then
            log -p i -t "FreezeQuickSearchClone" "分身应用冻结成功"
        else
            log -p w -t "FreezeQuickSearchClone" "分身应用冻结失败，尝试使用hide方法"
            pm hide --user $CLONE_USER_ID $PACKAGE_NAME
        fi
    else
        log -p i -t "FreezeQuickSearchClone" "分身应用已处于冻结状态"
    fi
}

# 执行检查
check_and_freeze

done