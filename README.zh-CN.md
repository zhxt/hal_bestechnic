# Bestechnic HAL 模块

[English](README.md)

`hal_bestechnic` 为 BES2700YP 的 Zephyr 集成提供预编译 HAL 静态库、公共头文件、链接脚本及构建元数据。静态库由独立的 bootstrap 链接，BTH 和 M55 的 Zephyr 镜像不直接链接这些库；其他芯片需单独适配与验证。

## 获取与检查

首次使用请按集成仓的[环境准备与构建](https://github.com/zhxt/bestechnic-zephyr/blob/main/docs/getting-started.md)初始化工作区。在工作区根目录执行：

```sh
.venv/bin/python -m west update hal_bestechnic
.venv/bin/python -m west blobs fetch hal_bestechnic
.venv/bin/python bestechnic-zephyr/scripts/check_repo.py
```

集成仓的 `west.yml` 固定模块提交，模块检出在 `modules/hal/bestechnic/`。三个 `.a` 文件由 `west blobs fetch` 按 [zephyr/module.yml](zephyr/module.yml) 从 `bestechnic-blobs` 的固定提交下载并校验，保存在 `zephyr/blobs/`，不纳入本模块的 Git 跟踪。固件构建无需完整 BES SDK。更新时按集成仓锁定的版本同步，不要在模块目录单独执行 `git pull`。

检查结果应为 `status: pass`、`issues: []`。提交、文件哈希或编译器不匹配时，按集成仓的[HAL 排障说明](https://github.com/zhxt/bestechnic-zephyr/blob/main/docs/hal.md#检查失败时如何定位)核对。

## 模块组成与兼容条件

| 静态库 | 内容 |
|---|---|
| `libbes2700yp_system.a` | 时钟、电源、PMU、timer/UART/cache 及可达的 trace/DMA 等辅助依赖 |
| `libbes2700yp_flash.a` | norflash HAL/IP、驱动和 flash 配置 |
| `libbes2700yp_bootstrap_compat.a` | 厂商 startup、CMSIS/system、boot header 和部分 libc 兼容实现 |

模块还包含[公共 API](include/bestechnic/bes2700yp/hw.h)、[链接脚本](linker/bes2700yp/dual_v1.ld)及 [CMake 导入配置](cmake/import.cmake)；[manifest.json](manifest.json) 记录库版本、编译器、适用配置和文件哈希。

候选版本 0.2.0-rc1 适用于 BES2700YP、24 MHz、`dual_v1_24m_t2` profile 和 `cortex-m33-fpv5-sp-d16-hard` ABI。system 库增加 M55 CPU 保持复位时的 PARK 准备接口，另两个静态库与 0.1.0 版本逐字节一致。编译器版本须与 manifest 一致。这里的 Cortex-M33 是库的编译目标配置，不表示 BTH 的硬件核型号。

## 分发与验证状态

本仓面向学习研究与技术验证，不构成对厂商来源文件的使用或再分发授权。商用授权及第三方声明见 [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md)。

静态库和链接脚本的公开再分发依据尚未确认，状态见 [distribution.json](distribution.json)。构建通过不代表实板验收已完成；实板结果以集成仓的[测试说明](https://github.com/zhxt/bestechnic-zephyr/blob/main/docs/testing.md#实板验收)和对应镜像报告为准。
