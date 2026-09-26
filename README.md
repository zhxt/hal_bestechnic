# Bestechnic HAL Module

[简体中文](README.zh-CN.md)

`hal_bestechnic` provides prebuilt HAL libraries, a public header, a linker script, and build metadata for the BES2700YP Zephyr integration. A separate bootstrap program links the libraries; the BTH and M55 Zephyr images do not link them directly. Other chips require separate adaptation and validation.

## Fetch and check

Follow the integration repository's [getting-started guide](https://github.com/zhxt/bestechnic-zephyr/blob/main/docs/getting-started.md) to initialize a workspace. From the workspace root, run:

```sh
.venv/bin/python -m west update hal_bestechnic
.venv/bin/python -m west blobs fetch hal_bestechnic
.venv/bin/python bestechnic-zephyr/scripts/check_repo.py
```

The integration repository pins this module in `west.yml` and checks it out at `modules/hal/bestechnic/`. `west blobs fetch` downloads and verifies the three libraries declared in [zephyr/module.yml](zephyr/module.yml) from a pinned `bestechnic-blobs` commit. The files are stored under `zephyr/blobs/` and are not tracked by this module's Git repository. Building the firmware does not require the complete BES SDK. For updates, follow the revision pinned by the integration repository.

The check should report `status: pass` and `issues: []`. For revision, file hash, or compiler mismatches, see the integration repository's [HAL guide](https://github.com/zhxt/bestechnic-zephyr/blob/main/docs/hal.md).

## Contents and compatibility

| Library | Purpose |
|---|---|
| `libbes2700yp_system.a` | Clock, power, PMU, timer/UART/cache, and reachable trace/DMA dependencies |
| `libbes2700yp_flash.a` | NOR flash HAL/IP, drivers, and flash configuration |
| `libbes2700yp_bootstrap_compat.a` | Vendor startup, CMSIS/system, boot header, and libc compatibility code |

The module also includes a [public API](include/bestechnic/bes2700yp/hw.h), a [linker script](linker/bes2700yp/dual_v1.ld), and [CMake import configuration](cmake/import.cmake). [manifest.json](manifest.json) records the library version, compiler, build profile, and file hashes.

Candidate version 0.2.0-rc1 supports BES2700YP at 24 MHz with the `dual_v1_24m_t2` profile and `cortex-m33-fpv5-sp-d16-hard` ABI. The system library adds M55 PARK preparation while the peer CPU remains in reset; the other two archives retain their 0.1.0 bytes. The compiler version must match the manifest. Cortex-M33 here identifies the library build target; it does not identify the BTH hardware core.

## Distribution and validation

This repository is intended for study, research, and technical validation. Its availability does not grant permission to use or redistribute vendor-origin files. See [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md) for third-party notices and commercial-use considerations.

The basis for public redistribution of the libraries and linker script remains unconfirmed; see [distribution.json](distribution.json). A successful build does not establish hardware validation. See the integration repository's [test guide](https://github.com/zhxt/bestechnic-zephyr/blob/main/docs/testing.md) and the corresponding image report for hardware results.
