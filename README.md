# Bestechnic HAL Module

[简体中文](README.zh-CN.md)

`hal_bestechnic` supplies a public header, a linker script, build metadata, and blob declarations for prebuilt BES2700YP HAL libraries. A separate bootstrap program links the libraries; the BTH and M55 Zephyr images do not link them directly. Other chips require separate adaptation and validation.

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

The build profile, ABI, compiler, and artifact hashes are recorded in [manifest.json](manifest.json). The system library includes M55 PARK preparation for use while the peer CPU remains in reset. Cortex-M33 in the ABI identifies the library build target; it does not identify the BTH hardware core.

## Origin and records

This repository is intended for study, research, and technical validation. Its availability does not grant permission to use or redistribute vendor-origin files. See [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md) for third-party notices and commercial-use considerations.

See [distribution.json](distribution.json) for the recorded redistribution scope and evidence. Hardware results belong to the corresponding integration image report; the integration repository's [test guide](https://github.com/zhxt/bestechnic-zephyr/blob/main/docs/testing.md) describes how to record them.

## UART resource readback

The bootstrap facade `bes2700yp_uart0_read()` reads the BTH UART0 clock
selector, peripheral/functional gates and resets, and AON P2_2/P2_3 mux/pull.
It requires two matching bounded samples and does not write MMIO or acquire
the vendor IOMUX lock. Its caller must serialize BTH configuration access.
Validity bits separate configured clock, gate/reset and pin-route information.
PLL frequency, pad voltage and externally calibrated frequency are not claimed.
See [the public interface](include/bestechnic/bes2700yp/hw.h) for field semantics.

## Restricted GPIO access

`bes2700yp_gpio_access()` provides AON P2_0/P2_1 input pull-ups, P1_4 output and bounded readback. Its privileged BTH caller masks interrupts and serializes writes with lifecycle control. It attempts MEMSC0 once, refuses IRQ-owned pins and unavailable banks, preserves other pads, and never changes GPIO gates, bank reset, VIO or drive strength. Output use requires board voltage confirmation. The original facade adds no vendor GPIO source to the maintained subset; it is not a Zephyr GPIO/pinctrl driver. See the public header for operations, ownership and error semantics.
