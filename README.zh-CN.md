# Bestechnic HAL 模块

[English](README.md)

`hal_bestechnic` 为 BES2700YP 的 Zephyr 集成提供公共头文件、链接脚本、构建元数据及预编译 HAL 静态库的 blob 描述。静态库由独立的 bootstrap 链接，BTH 和 M55 的 Zephyr 镜像不直接链接这些库；其他芯片需单独适配与验证。

## 获取与检查

首次使用请按集成仓的[环境准备与构建](https://github.com/zhxt/bestechnic-zephyr/blob/main/docs/getting-started.zh-CN.md)初始化工作区。在工作区根目录执行：

```sh
.venv/bin/python -m west update hal_bestechnic
.venv/bin/python -m west blobs fetch hal_bestechnic
.venv/bin/python bestechnic-zephyr/scripts/check_repo.py
```

集成仓的 `west.yml` 固定模块提交，模块检出在 `modules/hal/bestechnic/`。三个 `.a` 文件由 `west blobs fetch` 按 [zephyr/module.yml](zephyr/module.yml) 从 `bestechnic-blobs` 的固定提交下载并校验，保存在 `zephyr/blobs/`，不纳入本模块的 Git 跟踪。固件构建无需完整 BES SDK。更新时按集成仓锁定的版本同步，不要在模块目录单独执行 `git pull`。

检查结果应为 `status: pass`、`issues: []`。提交、文件哈希或编译器不匹配时，按集成仓的[HAL 排障说明](https://github.com/zhxt/bestechnic-zephyr/blob/main/docs/hal.zh-CN.md#检查失败时如何定位)核对。

## 模块组成与兼容条件

| 静态库 | 内容 |
|---|---|
| `libbes2700yp_system.a` | 时钟、电源、PMU、timer/UART/cache 及可达的 trace/DMA 等辅助依赖 |
| `libbes2700yp_flash.a` | norflash HAL/IP、驱动和 flash 配置 |
| `libbes2700yp_bootstrap_compat.a` | 厂商 startup、CMSIS/system、boot header 和部分 libc 兼容实现 |

模块还包含[公共 API](include/bestechnic/bes2700yp/hw.h)、[链接脚本](linker/bes2700yp/dual_v1.ld)及 [CMake 导入配置](cmake/import.cmake)；[manifest.json](manifest.json) 记录库版本、编译器、适用配置和文件哈希。

构建配置、ABI、编译器和制品哈希见 [manifest.json](manifest.json)。system 库包含 M55 CPU 保持复位时使用的 PARK 准备接口。ABI 中的 Cortex-M33 是库的编译目标配置，不表示 BTH 的硬件核型号。

## 来源与记录

本仓面向学习研究与技术验证，不构成对厂商来源文件的使用或再分发授权。商用授权及第三方声明见 [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md)。

分发范围与依据见 [distribution.json](distribution.json)；实板结果由对应的集成镜像报告记录，记录方式见集成仓的[测试说明](https://github.com/zhxt/bestechnic-zephyr/blob/main/docs/testing.zh-CN.md#实板验收)。

## UART 资源读回

bootstrap facade `bes2700yp_uart0_read()` 读取 BTH UART0 时钟选择、总线/功能门控及复位、AON P2_2/P2_3 的 mux/pull。
接口要求两次有界采样一致，不写 MMIO、不取得厂商 IOMUX 锁；调用方须串行化 BTH 配置访问。
有效位区分配置频率、门控/复位和引脚路由信息，不声明 PLL 频率、pad 电压或外部校准频率。
字段语义见[公共接口](include/bestechnic/bes2700yp/hw.h)。
