# FUCK Oppo QuickSearchBox 模块
By 酷安福瑞@小黄泊
功能描述
本Magisk模块用于自动将`com.heytap.quicksearchbox`（全局搜索）应用多开分身到MultiApp分区，并冻结该分身应用。

主要功能
1. 自动多开分身: 在MultiApp分区创建全局搜索的分身应用
2. 自动冻结: 使用root权限冻结分身应用，使其无法运行

技术原理
- 使用`pm create-user`创建MultiApp用户空间
- 使用`pm install-existing`在分身用户中安装应用
- 使用`pm disable`和`pm hide`冻结应用
- 服务脚本确保重启后保持冻结状态

安装方法
1. 将整个模块文件夹复制到手机存储
2. 在Magisk Manager中安装模块
3. 重启手机

文件结构
```
freeze_quicksearchbox_clone/
├── module.prop          # 模块配置信息
├── customize.sh         # 安装脚本
├── service.sh           # 服务脚本（启动时执行）
├── uninstall.sh         # 卸载脚本
└── README.md           # 说明文档
```

注意事项
- 需要完整的root权限
- 需要Android系统支持多用户功能
- 模块仅冻结分身应用，不影响原始应用
- 卸载模块时会删除分身应用

兼容性
- 主要针对OPPO/Realme/OnePlus设备优化

调试信息
如果遇到问题，可以检查：
- 系统日志中的`FreezeQuickSearchClone`标签
- 使用`pm list packages --user 999`查看分身应用状态
- 使用`pm list users`查看用户列表