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
#endif
