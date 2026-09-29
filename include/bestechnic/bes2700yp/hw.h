/* SPDX-License-Identifier: Apache-2.0 */
#ifndef BESTECHNIC_BES2700YP_HW_H
#define BESTECHNIC_BES2700YP_HW_H
#include <stdint.h>

/* Bootstrap-only ABI: Cortex-M33, hard float, dual_v1_24m_t2. */
#define BES2700YP_HW_ABI 1U
#define BES2700YP_REPARK_API 1U
#define BES2700YP_REPARK_FIELDS(X) \
 X(reason) X(reset_before) X(reset_after) \
 X(sel0_before) X(sel1_before) X(sel0_axi) X(sel1_axi) X(sel0_after) X(sel1_after) \
 X(phys0) X(phys1) X(phys2) X(expected0) X(expected1) X(expected2) \
 X(read0) X(read1) X(read2) X(restore_ok) X(write_mask)
struct bes2700yp_repark_result {
#define BES2700YP_PARK_MEMBER(n) uint32_t n;
 BES2700YP_REPARK_FIELDS(BES2700YP_PARK_MEMBER)
#undef BES2700YP_PARK_MEMBER
};
/* Requires sole ownership and peer CPU held reset. Prepares only; never releases.
 * Temporarily remaps physical bank 9, restores its original selector on failure.
 * Returns 0 or -(20+reason): reset=1, ownership=2, mapping=3, write=4,
 * restore=5, reset lost=6. The caller must not release on any error. */
int bes2700yp_m55_repark_prepare(struct bes2700yp_repark_result *result);
#define BES2700YP_SLOW_HZ 16000U
#define BES2700YP_SLOW_NOMINAL_HZ 16000U
struct bes2700yp_hw_snapshot {
	uint32_t core_vtor, reset_set, reset_clr, ram_sel0, ram_sel1;
	uint32_t oclk, oreset, sysclk;
};
int bes2700yp_uart_open(void);
int bes2700yp_pmu_open(void);
void bes2700yp_watchdogs_stop(void);
int bes2700yp_bth_clock_24m(void);
uint32_t bes2700yp_crystal_hz(void);
uint32_t bes2700yp_fast_timer_hz(void);
void bes2700yp_timer_open(void);
void bes2700yp_dcache_disable(void);
void bes2700yp_icache_disable(void);
int bes2700yp_clocks_are_24m(void);
int bes2700yp_m55_prepare(void);
void bes2700yp_m55_park_word(uint32_t address, uint32_t value);
void bes2700yp_m55_dtcm_enable(void);
void bes2700yp_m55_start(uint32_t vector);
void bes2700yp_m55_stop(void);
void bes2700yp_snapshot(struct bes2700yp_hw_snapshot *snapshot);
/* BTH UART0 resource readback; caller is the sole privileged BTH owner.
 * valid: bit0 configured clock, bit1 gate/reset, bit2 AON pin route.
 * source: 1 crystal, 2 crystal x2, 3 PLL (frequency unavailable).
 * clocks/reset_released: bit0 peripheral bus, bit1 functional clock/reset.
 * Pins use bank*8+index. Pull masks: bit0 RX, bit1 TX.
 * No physical voltage or calibrated frequency claim. No MMIO writes/locks.
 * Return -1 for null output, -2 for a changing snapshot; discard on error. */
#define BES2700YP_UART_READBACK_API 1U
struct bes2700yp_uart0_state {
	uint32_t valid;
	uint32_t source;
	uint32_t source_hz;
	uint32_t divider;
	uint32_t configured_hz;
	uint32_t clocks;
	uint32_t reset_released;
	uint32_t rx_pin;
	uint32_t tx_pin;
	uint32_t rx_mux;
	uint32_t tx_mux;
	uint32_t pull_up;
	uint32_t pull_down;
};
int bes2700yp_uart0_read(struct bes2700yp_uart0_state *state);
/* Restricted AON GPIO access. BTH privileged thread, with local IRQs masked.
 * P2_0/P2_1: input pull-up; P1_4: push-pull output after board voltage review.
 * P1_5 and UART pads are read/protected, never claimed. Existing bank clock
 * and reset must already be usable; no bank reset, VIO or drive changes.
 * AON MEMSC 0 is tried once per operation, never waited on. IRQ-owned target
 * pins are refused. Readback failure leaves the target as input.
 * Return: -1 invalid, -2 busy, -3 bank unavailable, -4 readback failure.
 * Snapshot output is valid only on success. Voltages are not measured. */
#define BES2700YP_GPIO_API 1U
#define BES2700YP_GPIO_KEYS ((1U << 16) | (1U << 17))
#define BES2700YP_GPIO_LED (1U << 12)
#define BES2700YP_GPIO_PINS (BES2700YP_GPIO_KEYS | (3U << 12))
#define BES2700YP_GPIO_READ 1U
#define BES2700YP_GPIO_INPUT 2U
#define BES2700YP_GPIO_OUTPUT 3U
#define BES2700YP_GPIO_WRITE 4U
struct bes2700yp_gpio_state {
 uint32_t pins, inputs, directions, outputs, mux_led, mux_keys;
 uint32_t pull_up, pull_down, clocks, resets, irq_enabled, control;
};
int bes2700yp_gpio_access(uint32_t op, uint32_t pin, uint32_t value,
                         struct bes2700yp_gpio_state *state);
#endif
