/***************************************************************************
 *
 * Copyright 2015-2019 BES.
 * All rights reserved. All unpublished rights reserved.
 *
 * No part of this work may be used or reproduced in any form or by any
 * means, or stored in a database or retrieval system, without prior written
 * permission of BES.
 *
 * Use of this work is governed by a license granted by BES.
 * This work contains confidential and proprietary information of
 * BES. which is protected by copyright, trade secret,
 * trademark and other intellectual property rights.
 *
 ****************************************************************************/
/***************************************************************************
 *
 * Copyright 2015-2020 BES.
 * All rights reserved. All unpublished rights reserved.
 *
 * No part of this work may be used or reproduced in any form or by any
 * means, or stored in a database or retrieval system, without prior written
 * permission of BES.
 *
 * Use of this work is governed by a license granted by BES.
 * This work contains confidential and proprietary information of
 * BES. which is protected by copyright, trade secret,
 * trademark and other intellectual property rights.
 *
 ****************************************************************************/
/***************************************************************************
 *
 * Copyright 2020-2021 BES.
 * All rights reserved. All unpublished rights reserved.
 *
 * No part of this work may be used or reproduced in any form or by any
 * means, or stored in a database or retrieval system, without prior written
 * permission of BES.
 *
 * Use of this work is governed by a license granted by BES.
 * This work contains confidential and proprietary information of
 * BES. which is protected by copyright, trade secret,
 * trademark and other intellectual property rights.
 *
 ****************************************************************************/
/* Hardware definitions */
/* SYS RAM0/1 share with M55/HIFI4 I/DTCM */
/* RAM config */
/***************************************************************************
 *
 * Copyright 2021-2022 BES.
 * All rights reserved. All unpublished rights reserved.
 *
 * No part of this work may be used or reproduced in any form or by any
 * means, or stored in a database or retrieval system, without prior written
 * permission of BES.
 *
 * Use of this work is governed by a license granted by BES.
 * This work contains confidential and proprietary information of
 * BES. which is protected by copyright, trade secret,
 * trademark and other intellectual property rights.
 *
 ****************************************************************************/
/* RAM config */
/* Mailbox config */
/* RAM config checks (only check in lds file, the first compiled file during build) */
/* Chip subtype definitions */
/***************************************************************************
 *
 * Copyright 2020-2021 BES.
 * All rights reserved. All unpublished rights reserved.
 *
 * No part of this work may be used or reproduced in any form or by any
 * means, or stored in a database or retrieval system, without prior written
 * permission of BES.
 *
 * Use of this work is governed by a license granted by BES.
 * This work contains confidential and proprietary information of
 * BES. which is protected by copyright, trade secret,
 * trademark and other intellectual property rights.
 *
 ****************************************************************************/
/* Retention RAM config check */
/* For linker scripts */
/* For module features */
/* #define CMU_FAST_TIMER_WITH_LOW_SYS_FREQ */
/* For boot struct version */
/* For ROM export functions */
/* Linker script to configure memory regions. */
/* See plat_addr_map.h and common.mk for the macro definitions */
MEMORY
{
 ROM (rx) : ORIGIN = 0x00020000, LENGTH = 0x00018000
 FLASH (r) : ORIGIN = (0x34000000), LENGTH = (0x800000 - ((0x34000000) - 0x34000000))
 FLASH_NC (r) : ORIGIN = (((0x34000000)) - 0x34000000 + 0x30000000), LENGTH = (0x800000 - ((0x34000000) - 0x34000000))
 FLASHX (rx) : ORIGIN = (((0x34000000)) - 0x34000000 + 0x14000000), LENGTH = (0x800000 - ((0x34000000) - 0x34000000))
 RAM (rwx) : ORIGIN = 0x20500000, LENGTH = 0x10000 - 0x1000
 RAMX (rx) : ORIGIN = (0x20500000 - 0x20500000 + 0x00500000), LENGTH = 0x10000 - 0x1000
 FRAMX (rwx) : ORIGIN = (0x20500000 - 0x20500000 + 0x00500000) + 0x10000 - 0x1000, LENGTH = 0x1000
}
/* Library configurations */
GROUP(libgcc.a libc.a libm.a libnosys.a)
/* Linker script to place sections and symbol values. Should be used together
 * with other linker script that defines memory regions FLASH and RAM.
 * It references following symbols, which must be defined in code:
 *   Reset_Handler : Entry of reset handler
 *
 * It defines following symbols, which code can use without definition:
 *   __export_fn_rom
 *   __exidx_start
 *   __exidx_end
 *   __copy_table_start__
 *   __copy_table_end__
 *   __zero_table_start__
 *   __zero_table_end__
 *   __etext
 *   __data_start__
 *   __preinit_array_start
 *   __preinit_array_end
 *   __init_array_start
 *   __init_array_end
 *   __fini_array_start
 *   __fini_array_end
 *   __data_end__
 *   __bss_start__
 *   __bss_end__
 *   __end__
 *   end
 *   __HeapLimit
 *   __StackLimit
 *   __StackTop
 *   __stack
 *   __free_ram
 *   __factory_start
 *   __factory_end
 *   __calib_start
 *   __calib_end
 *   __flash_start
 *   __flash_end
 *   __free_flash
 *   __flash1_start
 *   __flash1_end
 *   __free_flash1
 *   __boot_sram_start_flash__
 *   __boot_sram_end_flash__
 *   __boot_sram_start__
 *   __boot_bss_sram_start__
 *   __boot_bss_sram_end__
 *   __sram_text_data_start_flash__
 *   __sram_text_data_end_flash__
 *   __fast_sram_text_data_start__
 *   __fast_sram_text_data_end__
 *   __fast_sram_text_data_start_flash__
 *   __fast_sram_text_data_end_flash__
 *   __sram_text_data_start__
 *   __sram_bss_start__
 *   __sram_bss_end__
 *   __overlay_text_start__
 *   __overlay_text_exec_start__
 *   __overlay_data_start__
 */
ENTRY(Boot_Loader)
SECTIONS
{
 __export_fn_rom = (ORIGIN(ROM) + LENGTH(ROM) - 40 - 128);
 .boot_struct (ORIGIN(FLASH)) :
 {
  __flash_start = .;
  KEEP(*(.boot_struct))
  . = ALIGN(4);
 } > FLASH
 . = ((.) - 0x34000000 + 0x14000000);
 .boot_text_flash (.) : AT (((ADDR(.boot_text_flash)) - 0x14000000 + 0x34000000))
 {
  __flashx_start_addr__ = .;
  *(.boot_loader)
  *(.boot_text_flash*)
  *(.boot_rodata_flash*)
  . = ALIGN(4);
 } > FLASHX
 . = ((.) - 0x14000000 + 0x34000000);
 .got_info (.) :
 {
  __got_info_start = .;
  __got_plt_start = .;
  *(.got.plt)
  __got_plt_end = .;
  __got_start = .;
  *(.got)
  __got_end = .;
  . = ALIGN(4);
 } > FLASH
 .vector_table (ORIGIN(RAM)) (NOLOAD) :
 {
  __vector_table_start = .;
  KEEP(*(.vector_table))
  . = 320;
  . = ALIGN(4);
 } > RAM
 .reboot_param (NOLOAD) :
 {
  KEEP(*(.reboot_param))
  . = 64;
  . = ALIGN(4);
 } > RAM
 .userdata_pool (NOLOAD) :
 {
  *(.userdata_pool)
  . = ALIGN(4);
  __userdata_pool_end__ = .;
 } > RAM
 __boot_sram_start_flash__ = LOADADDR(.got_info) + SIZEOF(.got_info);
 __boot_sram_start__ = ALIGN(__userdata_pool_end__, 32);
 .boot_text_sram
  (((__boot_sram_start__) - 0x20500000 + (0x20500000 - 0x20500000 + 0x00500000)))
  : AT (__boot_sram_start_flash__)
 {
  __boot_text_sram_start__ = .;
  _stext = __boot_text_sram_start__;
  /* memcpy.o/memcpy_move-kp.o or libc_nano.a(lib_a-memcpy.o/lib_a-memcpy-stub.o) */
  *:memcpy*.o(.text*)
  *:lib_a-memcpy*.o(.text*)
  *:libc_rom.o(.text*)
  *:libc_rom_mem.o(.text*)
  /* memset.o/memset-kp.o or libc_nano.a(lib_a-memset.o) */
  *:memset*.o(.text*)
  *:aeabi_memset.o(.text*)
  *:aeabi_memset-soft.o(.text*)
  *:lib_a-memset*.o(.text*)
  *:hal_norflash*.o(.text*)
  *:norflash_*.o(EXCLUDE_FILE(*:norflash_api.o) .text*)
  *(.boot_text_sram*)
  . = ALIGN(32);
  __boot_text_sram_end__ = .;
 } > RAMX
 __boot_text_sram_end_flash__ = __boot_sram_start_flash__ + SIZEOF(.boot_text_sram);
 __boot_data_sram_start_flash__ = __boot_text_sram_end_flash__;
 .boot_data_sram
  (((ADDR(.boot_text_sram) + SIZEOF(.boot_text_sram)) - (0x20500000 - 0x20500000 + 0x00500000) + 0x20500000))
  : AT (__boot_data_sram_start_flash__)
 {
  __boot_data_sram_start__ = .;
  *:hal_norflash*.o(.data* .rodata*)
  *:norflash_*.o(EXCLUDE_FILE(*:norflash_api.o) .data* EXCLUDE_FILE(*:norflash_api.o) .rodata*)
  *:libc_rom.o(.rodata*)
  *:libc_rom_mem.o(.rodata*)
  /* Stack protector instrumentation rodata for functions in special sections */
  *(.rodata.cst4)
  *(.boot_rodata_sram*)
  *(.boot_data*)
  . = ALIGN(4);
  __boot_data_sram_end__ = .;
 } > RAM
 __boot_sram_end_flash__ = __boot_data_sram_start_flash__ + SIZEOF(.boot_data_sram);
 .boot_bss_sram (.) (NOLOAD) : AT (ADDR(.boot_bss_sram))
 {
  __boot_bss_sram_start__ = .;
  *:hal_norflash*.o(.bss*)
  *:norflash_*.o(EXCLUDE_FILE(*:norflash_api.o) .bss*)
  *(.boot_bss*)
  . = ALIGN(4);
  __boot_bss_sram_end__ = .;
 } > RAM
 __sram_text_data_start_flash__ = __boot_sram_end_flash__;
 __sram_text_data_start__ = ALIGN(__boot_bss_sram_end__, 32);
 .sram_text (((__sram_text_data_start__) - 0x20500000 + (0x20500000 - 0x20500000 + 0x00500000))) : AT (__sram_text_data_start_flash__)
 {
  __sram_text_start__ = .;
  *:norflash_api.o(.text*)
  *(.sram_text*)
  /*
		   If you want protect one section by armv8's mpu, the section should
		   be aligned to 32bytes
		 */
  . = ALIGN(32);
  __sram_text_end__ = .;
 } > RAMX
 __sram_text_end_flash__ = __sram_text_data_start_flash__ + SIZEOF(.sram_text);
 __sram_data_start_flash__ = __sram_text_end_flash__;
 .sram_data
  (((ADDR(.sram_text) + SIZEOF(.sram_text)) - (0x20500000 - 0x20500000 + 0x00500000) + 0x20500000))
  : AT (__sram_data_start_flash__)
 {
  __sram_data_start__ = .;
  *:utils.o(.data* .rodata*)
  *:cqueue.o(.data* .rodata*)
  *:iir_process.o(.data* .rodata*)
  *:sbcplc.o(.data* .rodata*)
  *:sbc.o(.data* .rodata*)
  *:sbc_math.o(.data* .rodata*)
  *:crossover_filter.o(.data* .rodata*)
  *:exp_func_tables.o(.data* .rodata*)
  *:sbcplc.o(.data* .rodata*)
  *:norflash_api.o(.rodata*)
  . = ALIGN(4);
  _hdf_drivers_start = .;
  KEEP(*(.hdf.driver))
  _hdf_drivers_end = .;
  *(.sram_rodata*)
  *(.sram_data*)
  *(.cp_data*)
  . = ALIGN(4);
  __sram_data_end__ = .;
 } > RAM
 __sram_text_data_end_flash__ = __sram_data_start_flash__ + SIZEOF(.sram_data);
 .sram_bss (.) (NOLOAD) : AT (ADDR(.sram_bss))
 {
  __sram_bss_start__ = .;
  *:utils.o(.bss*)
  *(.sram_bss*)
  *(.cp_bss*)
  *:wifi_hal_best1600(.bss*)
  *:wifi_sdio_host.o(.bss*)
  . = ALIGN(32);
  __sram_bss_end__ = .;
 } > RAM
 __fast_sram_text_data_start_flash__ = __sram_text_data_end_flash__;
 .fast_text_sram : AT (__fast_sram_text_data_start_flash__)
 {
  __fast_sram_text_exec_start__ = .;
  /* memmove.o or libc_nano.a(lib_a-memmove.o) */
  *:memmove*.o(.text*)
  *:lib_a-memmove.o(.text*)
  *:utils.o(.text*)
  *:cqueue.o(.text*)
  *:audio_resample_ex.o(.text*)
  *:sbc.o(.text*.sbc_is_stream_info_valid)
  *:sbc.o(.text*.sbc_frame_length_get)
  *:sbc.o(.text*.sbc_4bit_crc_calc)
  *:sbc.o(.text*.sbc_bits_for_mono_alloc)
  *:sbc.o(.text*.sbc_bits_for_stereo_alloc)
  *:sbc.o(.text*.sbc_header_process)
  *:sbc.o(.text*.sbc_factors_process)
  *:sbc.o(.text*.sbc_sample_extract)
  *:sbc.o(.text*.sbc_sbsamples_make)
  *:sbc.o(.text*.sbc_joint_process)
  *:sbc.o(.text*.sbc_4band_synth_filter)
  *:sbc.o(.text*.sbc_8band_synth_filter)
  *:sbc.o(.text*.sbc_decoder_state_reset)
  *:sbc.o(.text*.sbc_frame_mute)
  *:sbc.o(.text*.sbc_frames_decode)
  *:sbc.o(.text*.sbc_frames_decode_do)
  *:sbc.o(.text*.sbc_frames_decode_select_channel)
  *:sbc.o(.text*.sbc_frames_decode)
  *:sbc.o(.text*.sbc_samples_quant)
  *:sbc.o(.text*.sbc_decoder_init)
  *:sbc.o(.text*.sbc_encoder_init)
  *:sbc.o(.text*.sbc_frames_encode)
  *:sbc_math.o(.text*)
  *:crossover_filter.o(.text*)
  *:data_compressor.o(.text*)
  *:drc.o(.text*)
  *:limiter.o(.text*)
  :audio_prompt_sbc.o(.text*)
  *:sbcplc.o(.text*)
  *:iirfilt.o(.text*)
  *(.fast_text_sram*)
  *(.cp_text_sram*)
  /*
		   If you want protect one section by armv8's mpu, the section should
		   be aligned to 32bytes
		 */
  . = ALIGN(32);
  __fast_sram_text_exec_end__ = .;
 } > FRAMX
 __fast_sram_text_data_end_flash__ = __fast_sram_text_data_start_flash__ + SIZEOF(.fast_text_sram);
 __fast_sram_text_data_start__ = ((__fast_sram_text_exec_start__) - (0x20500000 - 0x20500000 + 0x00500000) + 0x20500000);
 __fast_sram_text_data_end__ = ((__fast_sram_text_exec_end__) - (0x20500000 - 0x20500000 + 0x00500000) + 0x20500000);
 __overlay_text_start_flash__ = __fast_sram_text_data_end_flash__;
 __overlay_text_start__ = ALIGN(__fast_sram_text_data_end__, 32);
 __overlay_text_exec_start__ = ((__overlay_text_start__) - 0x20500000 + (0x20500000 - 0x20500000 + 0x00500000));
 OVERLAY (__overlay_text_exec_start__) : NOCROSSREFS AT (__overlay_text_start_flash__)
 {
  .overlay_text0
  {
   LONG(0);
   *:kiss_fft.o(.text*)
   *:kiss_fftr.o(.text*)
   *:fftwrap.o(.text*)
   *:cmsis_fftwrap.o(.text*)
   *:arm_rfft_fast_f32.o(.text*)
   *:arm_cfft_f32.o(.text*)
   /* common */
   *:ae_common.o(.text*)
   *:ae_rand.o(.text*)
   *:fastmath.o(.text*)
   *:integer_delay.o(.text*)
   *:ringbuf.o(.text*)
   *:scale_int16.o(.text*)
   *:speech_conv.o(.text*)
   *:speech_trans_buf.o(.text*)
   *:frame_resize.o(.text*)
   *:buffer_manager.o(.text*)
   *:plc_8000.o(.text*)
   *:dspfns.o(.text*)
   *:lpc_plc.o(.text*)
   *:plc_16000.o(.text*)
   *:sbc_filter.o(.text*)
   *:preprocess.o(.text*)
   *:filterbank.o(.text*)
   *:mdf.o(.text*)
   *(.overlay_text0)
   . = ALIGN(4);
  }
  .overlay_text1
  {
   LONG(0);
   *:fixedpoint.o(.text*)
   *:replaygain.o(.text*)
   *:dsp_core.o(.text*)
   *:dsp_misc.o(.text*)
   *:dsp_filter.o(.text*)
   *:dsp_sample_input.o(.text*)
   *:dsp_sample_output.o(.text*)
   *:eq.o(.text*)
   *:pga.o(.text*)
   *:fir_process.o(.text*)
   *:iir_process.o(.text*.iir_run .text*.*iir_run_per_*)
   *(.overlay_a2dp_sbc*)
   *(.overlay_text1)
   . = ALIGN(4);
  }
  .overlay_text2
  {
   LONG(0);
      *:lc3_com.o(.text*)
      *:lc3_dec.o(.text*)
      *:lc3_enc.o(.text*)
      *(.overlay_a2dp_lc3*)
   *(.overlay_text2)
   . = ALIGN(4);
  }
  .overlay_text3
  {
   LONG(0);
   *:fft128dot.o(.text*)
   *(.overlay_text3)
   . = ALIGN(4);
  }
  .overlay_text4
  {
   LONG(0);
   *(.overlay_a2dp_aac*)
   *(.overlay_text4)
   . = ALIGN(4);
  }
  .overlay_text5
  {
   LONG(0);
   *:mpa.o(.text*)
   *:bit.o(.text*)
   *:frame.o(.text*)
   *:huffman.o(.text*)
   *:layer12.o(.text*)
   *:layer3.o(.text*)
   *:stream.o(.text*)
   *:synth.o(.text*)
   *(.overlay_text5)
   . = ALIGN(4);
  }
  .overlay_text6
  {
   LONG(0);
   *:mp3_dec.o(.text*)
   *:mp3_enc.o(.text*)
   *(.overlay_text6)
   . = ALIGN(4);
  }
  .overlay_text7
  {
   LONG(0);
   *:opus_com.o(.text*)
   *(.overlay_text7)
   . = ALIGN(4);
  }
  .overlay_text8
  {
   LONG(0);
   *:ogg_com.o(.text*)
   *:vorbis_com.o(.text*)
   *(.overlay_text8)
   . = ALIGN(4);
  }
  .overlay_text9
  {
   LONG(0);
   *:alac_com.o(.text*)
   *(.overlay_text9)
   . = ALIGN(4);
  }
  .overlay_text10
  {
   LONG(0);
   *:flac_com.o(.text*)
   *(.overlay_text10)
   . = ALIGN(4);
  }
  .overlay_text11
  {
   LONG(0);
   *(.overlay_text11)
   . = ALIGN(4);
  }
  .overlay_text_last
  {
   LONG(0);
   . = ALIGN(4);
  }
 } > FRAMX
 .dummy_overlay_text_end (.) (NOLOAD) : AT (ADDR(.dummy_overlay_text_end))
 {
  __overlay_text_exec_end__ = .;
 } > FRAMX
 __fast_sram_end__ = ((__overlay_text_exec_end__) - (0x20500000 - 0x20500000 + 0x00500000) + 0x20500000);
 ASSERT(__fast_sram_end__ - __fast_sram_text_data_start__ <= 0x1000, "fast xram sections too large")
 __free_fram = 0x1000 - (__fast_sram_end__ - __fast_sram_text_data_start__);
 __overlay_data_start__ = __sram_bss_end__;
 OVERLAY (__overlay_data_start__) : NOCROSSREFS AT (__load_stop_overlay_text_last)
 {
  .overlay_data0
  {
   /* Explicitly place 4 bytes at section start to avoid "section type changed to PROGBITS" warnings */
   LONG(0);
   *:fftwrap.o(.data* .rodata*)
   *:kiss_fft.o(.data* .rodata*)
   *:kiss_fftr.o(.data* .rodata*)
   *:CommonTables.o(.rodata.armBitRevIndexTable256)
   *:CommonTables.o(.rodata.twiddleCoef_256)
   *:CommonTables.o(.rodata.twiddleCoef_rfft_512)
   *:CommonTables.o(.rodata.armBitRevIndexTable128)
   *:CommonTables.o(.rodata.twiddleCoef_128)
   *:CommonTables.o(.rodata.twiddleCoef_rfft_256)
   /* common */
   *:fastmath_const.o(.data* .rodata*)
   *:preprocess.o(.data* .rodata*)
   *:filterbank.o(.data* .rodata*)
   *:plc_8000.o(.data* .rodata*)
   *:table.o(.data* .rodata*)
   *:plc_16000.o(.data* .rodata*)
   *:mdf.o(.data* .rodata*)
   *(.overlay_data0 .overlay_rodata0)
   . = ALIGN(4);
   *(.overlay_sco_cache*)
   . = ALIGN(4);
  }
  .overlay_data1
  {
   LONG(0);
   *:fixedpoint.o(.data* .rodata*)
   *:replaygain.o(.data* .rodata*)
   *:dsp_core.o(.data* .rodata*)
   *:dsp_misc.o(.data* .rodata*)
   *:dsp_filter.o(.data* .rodata*)
   *:dsp_sample_input.o(.data* .rodata*)
   *:dsp_sample_output.o(.data* .rodata*)
   *:eq.o(.data* .rodata*)
   *:pga.o(.data* .rodata*)
   *:fir_process.o(.data* .rodata*)
   *(.overlay_data1 .overlay_rodata1)
   . = ALIGN(4);
  }
  .overlay_data2
  {
   LONG(0);
   *:lc3_com.o(.data* .rodata*)
   *:lc3_dec.o(.data* .rodata*)
   *:lc3_enc.o(.data* .rodata*)
   *(.overlay_data2 .overlay_rodata2)
   . = ALIGN(4);
  }
  .overlay_data3
  {
   LONG(0);
   *:fft128dot.o(.data* .rodata*)
   *(.overlay_data3 .overlay_rodata3)
   . = ALIGN(4);
  }
  .overlay_data4
  {
   LONG(0);
   *(.overlay_data4 .overlay_rodata4)
   . = ALIGN(4);
  }
  .overlay_data5
  {
   LONG(0);
   *:mpa.o(.data* .bss*)
   *:bit.o(.data* .bss*)
   *:frame.o(.data* .bss*)
   *:huffman.o(.data* .bss*)
   *:layer12.o(.data* .bss*)
   *:layer3.o(.data* .bss*)
   *:stream.o(.data* .bss*)
   *:synth.o(.data* .bss*)
   *(.overlay_data5 .overlay_rodata5)
   . = ALIGN(4);
  }
  .overlay_data6
  {
   LONG(0);
   *:mp3_dec.o(.data* .rodata*)
   *:mp3_enc.o(.data* .rodata*)
   *(.overlay_data6 .overlay_rodata6)
   . = ALIGN(4);
  }
  .overlay_data7
  {
   LONG(0);
   *:opus_com.o(.data* .rodata*)
   *(.overlay_data7 .overlay_rodata7)
   . = ALIGN(4);
  }
  .overlay_data8
  {
   LONG(0);
   *:ogg_com.o(.text*)
   *:vorbis_com.o(.data* .rodata*)
   *(.overlay_data8 .overlay_rodata8)
   . = ALIGN(4);
  }
  .overlay_data9
  {
   LONG(0);
   *:alac_com.o(.data* .rodata*)
   *(.overlay_data9 .overlay_rodata9)
   . = ALIGN(4);
  }
  .overlay_data10
  {
   LONG(0);
   *:flac_com.o(.data* .rodata*)
   *(.overlay_data10 .overlay_rodata10)
   . = ALIGN(4);
  }
  .overlay_data11
  {
   LONG(0);
   *(.overlay_data11 .overlay_rodata11)
   . = ALIGN(4);
  }
  .overlay_data_last
  {
   LONG(0);
   . = ALIGN(4);
  }
 } > RAM
 .dummy_overlay_data_end (.) (NOLOAD) : AT (ADDR(.dummy_overlay_data_end))
 {
  __overlay_data_end__ = .;
 } > RAM
 ASSERT(__overlay_data_end__ - __overlay_data_start__ <= 0x8000, "overlay data sections too large")
 __flash_text_data_start__ = __load_stop_overlay_data_last;
 .text (((__flash_text_data_start__) - 0x34000000 + 0x14000000)) : AT (((ADDR(.text)) - 0x14000000 + 0x34000000))
 {
  *(.text*)
  *(.flash_text*)
  KEEP(*(.init))
  KEEP(*(.fini))
  _sinit = ABSOLUTE(.);
  /* .ctors */
  *crtbegin.o(.ctors)
  *crtbegin?.o(.ctors)
  *(EXCLUDE_FILE(*crtend?.o *crtend.o) .ctors)
  *(SORT(.ctors.*))
  *(.ctors)
  _einit = ABSOLUTE(.);
  /* .dtors */
  *crtbegin.o(.dtors)
  *crtbegin?.o(.dtors)
  *(EXCLUDE_FILE(*crtend?.o *crtend.o) .dtors)
  *(SORT(.dtors.*))
  *(.dtors)
 } > FLASHX
 .ARM.extab (.) : AT (((ADDR(.ARM.extab)) - 0x14000000 + 0x34000000))
 {
  *(.ARM.extab* .gnu.linkonce.armextab.*)
 } > FLASHX
 __exidx_start = .;
 /* .ARM.exidx contains R_ARM_PREL31 (+-0x40000000) offset to functions, which means
	 * the session location cannot be too far away from the function addresses */
 .ARM.exidx (.) : AT (((ADDR(.ARM.exidx)) - 0x14000000 + 0x34000000))
 {
  *(.ARM.exidx* .gnu.linkonce.armexidx.*)
  __flashx_text_end__ = .;
 } > FLASHX
 __exidx_end = .;
 . = ((.) - 0x14000000 + 0x34000000);
 .rodata (.) :
 {
  *(.rodata*)
  *(.flash_rodata*)
  *(.constdata)
  . = ALIGN(4);
  /* preinit data */
  PROVIDE_HIDDEN (__preinit_array_start = .);
  KEEP(*(.preinit_array))
  PROVIDE_HIDDEN (__preinit_array_end = .);
  . = ALIGN(4);
  /* init data */
  PROVIDE_HIDDEN (__init_array_start = .);
  KEEP(*(SORT(.init_array.*)))
  KEEP(*(.init_array))
  PROVIDE_HIDDEN (__init_array_end = .);
  . = ALIGN(4);
  /* finit data */
  PROVIDE_HIDDEN (__fini_array_start = .);
  KEEP(*(SORT(.fini_array.*)))
  KEEP(*(.fini_array))
  PROVIDE_HIDDEN (__fini_array_end = .);
  . = ALIGN(4);
  __cust_cmd_hldr_tbl_start = .;
  KEEP(*(.cust_cmd_hldr_tbl))
  __cust_cmd_hldr_tbl_end = .;
  . = ALIGN(4);
  __ai_gatt_server_table_start = .;
  KEEP(*(.ai_gatt_server_table))
  __ai_gatt_server_table_end = .;
  . = ALIGN(4);
  __ai_ble_handler_table_start = .;
  KEEP(*(.ai_ble_handler_table))
  __ai_ble_handler_table_end = .;
  . = ALIGN(4);
  __ai_spp_register_table_start = .;
  KEEP(*(.ai_spp_register_table))
  __ai_spp_register_table_end = .;
  . = ALIGN(4);
  __tota_handler_table_start = .;
  KEEP(*(.tota_handler_table))
  __tota_handler_table_end = .;
  . = ALIGN(4);
  __ai_handler_function_table_start = .;
  KEEP(*(.ai_handler_function_table))
  __ai_handler_function_table_end = .;
  . = ALIGN(4);
  __custom_handler_table_start = .;
  KEEP(*(.custom_handler_table))
  __custom_handler_table_end = .;
  . = ALIGN(4);
  __mixprompt_property_table_start = .;
  KEEP(*(.mixprompt_property_table))
  __mixprompt_property_table_end = .;
  . = ALIGN(4);
  __core_bridge_task_cmd_table_start = .;
  KEEP(*(.core_bridge_task_cmd_table))
  __core_bridge_task_cmd_table_end = .;
  . = ALIGN(4);
  __core_bridge_instant_cmd_table_start = .;
  KEEP(*(.core_bridge_instant_cmd_table))
  __core_bridge_instant_cmd_table_end = .;
  . = ALIGN(4);
  __rpc_bth_dsp_cmd_table_start = .;
  KEEP(*(.rpc_bth_dsp_cmd_table))
  __rpc_bth_dsp_cmd_table_end = .;
  . = ALIGN(4);
  __eshell_command_table_start = .;
  KEEP(*(.eshell_command_table))
  __eshell_command_table_end = .;
  . = ALIGN(4);
  __app_bt_sync_command_handler_table_start = .;
  KEEP(*(.app_bt_sync_command_handler_table))
  __app_bt_sync_command_handler_table_end = .;
  . = ALIGN(4);
  . = ALIGN(4);
   KEEP(*(.eh_frame*))
  *(.note.gnu.build-id)
  . = ALIGN(4);
  _etext = .;
 } > FLASH
/* zInit code and data - will be freed after init */
 .zInit (.) :
 {
  __zinitcall_bsp_start = .;
  KEEP (*(.zinitcall.bsp0.init))
  KEEP (*(.zinitcall.bsp1.init))
  KEEP (*(.zinitcall.bsp2.init))
  KEEP (*(.zinitcall.bsp3.init))
  KEEP (*(.zinitcall.bsp4.init))
  __zinitcall_bsp_end = .;
  . = ALIGN(4);
  __zinitcall_device_start = .;
  KEEP (*(.zinitcall.device0.init))
  KEEP (*(.zinitcall.device1.init))
  KEEP (*(.zinitcall.device2.init))
  KEEP (*(.zinitcall.device3.init))
  KEEP (*(.zinitcall.device4.init))
  __zinitcall_device_end = .;
  . = ALIGN(4);
  __zinitcall_core_start = .;
  KEEP (*(.zinitcall.core0.init))
  KEEP (*(.zinitcall.core1.init))
  KEEP (*(.zinitcall.core2.init))
  KEEP (*(.zinitcall.core3.init))
  KEEP (*(.zinitcall.core4.init))
  __zinitcall_core_end = .;
  . = ALIGN(4);
  __zinitcall_sys_service_start = .;
  KEEP (*(.zinitcall.sys.service0.init))
  KEEP (*(.zinitcall.sys.service1.init))
  KEEP (*(.zinitcall.sys.service2.init))
  KEEP (*(.zinitcall.sys.service3.init))
  KEEP (*(.zinitcall.sys.service4.init))
  __zinitcall_sys_service_end = .;
  . = ALIGN(4);
  __zinitcall_sys_feature_start = .;
  KEEP (*(.zinitcall.sys.feature0.init))
  KEEP (*(.zinitcall.sys.feature1.init))
  KEEP (*(.zinitcall.sys.feature2.init))
  KEEP (*(.zinitcall.sys.feature3.init))
  KEEP (*(.zinitcall.sys.feature4.init))
  __zinitcall_sys_feature_end = .;
  . = ALIGN(4);
  __zinitcall_run_start = .;
  KEEP (*(.zinitcall.run0.init))
  KEEP (*(.zinitcall.run1.init))
  KEEP (*(.zinitcall.run2.init))
  KEEP (*(.zinitcall.run3.init))
  KEEP (*(.zinitcall.run4.init))
  __zinitcall_run_end = .;
  . = ALIGN(4);
  __zinitcall_app_service_start = .;
  KEEP (*(.zinitcall.app.service0.init))
  KEEP (*(.zinitcall.app.service1.init))
  KEEP (*(.zinitcall.app.service2.init))
  KEEP (*(.zinitcall.app.service3.init))
  KEEP (*(.zinitcall.app.service4.init))
  __zinitcall_app_service_end = .;
  . = ALIGN(4);
  __zinitcall_app_feature_start = .;
  KEEP (*(.zinitcall.app.feature0.init))
  KEEP (*(.zinitcall.app.feature1.init))
  KEEP (*(.zinitcall.app.feature2.init))
  KEEP (*(.zinitcall.app.feature3.init))
         KEEP (*(.zinitcall.app.feature4.init))
  __zinitcall_app_feature_end = .;
  . = ALIGN(4);
  __zinitcall_test_start = .;
  KEEP (*(.zinitcall.test0.init))
  KEEP (*(.zinitcall.test1.init))
  KEEP (*(.zinitcall.test2.init))
  KEEP (*(.zinitcall.test3.init))
  KEEP (*(.zinitcall.test4.init))
  __zinitcall_test_end = .;
  . = ALIGN(4);
  __zinitcall_exit_start = .;
  KEEP (*(.zinitcall.exit0.init))
  KEEP (*(.zinitcall.exit1.init))
  KEEP (*(.zinitcall.exit2.init))
  KEEP (*(.zinitcall.exit3.init))
  KEEP (*(.zinitcall.exit4.init))
  __zinitcall_exit_end = .;
  . = ALIGN(4);
 } > FLASH
 /* To copy multiple FLASH to RAM sections,
	 * uncomment .copy.table section and,
	 * define __STARTUP_COPY_MULTIPLE in startup_ARMCMx.S */
 /*
	.copy.table (.) :
	{
		. = ALIGN(4);
		__copy_table_start__ = .;
		LONG (__etext)
		LONG (__data_start__)
		LONG (__data_end__ - __data_start__)
		LONG (__etext2)
		LONG (__data2_start__)
		LONG (__data2_end__ - __data2_start__)
		__copy_table_end__ = .;
	} > FLASH
	*/
 /* To clear multiple BSS sections,
	 * uncomment .zero.table section and,
	 * define __STARTUP_CLEAR_BSS_MULTIPLE in startup_ARMCMx.S */
 /*
	.zero.table (.) :
	{
		. = ALIGN(4);
		__zero_table_start__ = .;
		LONG (__bss_start__)
		LONG (__bss_end__ - __bss_start__)
		LONG (__bss2_start__)
		LONG (__bss2_end__ - __bss2_start__)
		__zero_table_end__ = .;
	} > FLASH
	*/
 /* Location counter can end up 2byte aligned with narrow Thumb code but
	   __etext is assumed by startup code to be the LMA of a section in RAM
	   which must be 4byte aligned */
 __etext = ALIGN(4);
 /* The VMA is either the end of overlay_data or the end of sram bss */
 .data : AT (__etext)
 {
  __data_start__ = .;
  _sdata = .;
  *(vtable)
  . = ALIGN(4);
  *(.data*)
  KEEP(*(.jcr*))
  /* All data end */
  . = ALIGN(4);
  __data_end__ = .;
  _edata = .;
        __shell_root_cmds_start = .;
        KEEP(*(SORT(.shell_root_cmd_*)));
        __shell_root_cmds_end = .;
 } > RAM
 .bss (.) (NOLOAD) : AT (ADDR(.bss))
 {
  . = ALIGN(4);
  __bss_start__ = .;
  _sbss = .;
  *(.bss .bss.*)
  *(COMMON)
  . = ALIGN(4);
  __bss_end__ = .;
  _ebss = .;
 } > RAM
 .framebuffer (.) (NOLOAD) :
 {
  . = ALIGN(32);
  KEEP(*(.framebuffer))
 } > RAM
 .reboot_custom_param (.) (NOLOAD) :
 {
  KEEP(*(.reboot_custom_param*))
  . = ALIGN(4);
  __reboot_custom_param_end__ = .;
 } > RAM
 .heap (.) (NOLOAD) :
 {
  . = ALIGN(8);
  __HeapBase = .;
  __end__ = .;
  end = __end__;
  . += 0x1000;
  . = ALIGN(8);
  __HeapLimit = .;
 } > RAM
 /* .stack_dummy section doesn't contains any symbols. It is only
	 * used for linker to calculate size of stack sections, and assign
	 * values to stack symbols later */
 .stack_dummy (.) (COPY) :
 {
  . = 0x1100;
  . = ALIGN(8);
 } > RAM
 /* Set stack top to end of RAM, and stack limit move down by
	 * size of stack_dummy section */
 __StackTop = ORIGIN(RAM) + LENGTH(RAM);
 __StackLimit = __StackTop - SIZEOF(.stack_dummy);
 PROVIDE(__stack = __StackTop);
 /* Check if data + heap + stack exceeds RAM limit */
 ASSERT(__StackLimit >= __HeapLimit, "region RAM overflowed with stack")
 __free_ram = __StackLimit - __HeapLimit;
 __mem_pool_start__ = __HeapLimit;
 __mem_pool_end__ = __StackLimit;
 . = __etext + SIZEOF(.data);
 .build_info (.) :
 {
  KEEP(*(.build_info))
  . = ALIGN(4);
 } > FLASH = 0x00000000
 /* The following section MUST be the last loaded section */
 .code_start_addr (.) :
 {
  LONG(0);
  LONG(0xBE57341D);
  LONG(ABSOLUTE(__flash_start));
 } > FLASH
 __flash_end = .;
 .combo (ORIGIN(FLASH_NC) + LENGTH(FLASH_NC) - 0x1000 - 0x1000 -
  0 - 0x1000*2 - 0x1000 -
  0 - 0 - 0 -
  0 - 0 - 0 - 0 - 0x0 - 0x0 -
  0) (NOLOAD):
 {
  __combo_start = .;
  . = 0;
  __combo_end = .;
 } > FLASH_NC
 .prompt (ORIGIN(FLASH_NC) + LENGTH(FLASH_NC) - 0x1000 - 0x1000 -
  0 - 0x1000*2 - 0x1000 -
  0 - 0 - 0 -
  0 - 0 - 0 - 0 - 0x0 - 0x0) (NOLOAD):
 {
  __prompt_start = .;
  . = 0x0;
  __prompt_end = .;
 } > FLASH_NC
 .hotword_model (ORIGIN(FLASH_NC) + LENGTH(FLASH_NC) - 0x1000 - 0x1000 -
  0 - 0x1000*2 - 0x1000 -
  0 - 0 - 0 -
  0 - 0 - 0 - 0 -
  0x0) (NOLOAD):
 {
  __hotword_model_start = .;
  . = 0x0;
  __hotword_model_end = .;
 } > FLASH_NC
 .ramdump_section (ORIGIN(FLASH_NC) + LENGTH(FLASH_NC) - 0x1000 - 0x1000 -
  0 - 0x1000*2 - 0x1000 -
  0 - 0 - 0 -
  0 - 0 - 0 - 0) (NOLOAD) :
 {
  __ramdump_section_start = .;
  . = 0;
  __ramdump_section_end = .;
 } > FLASH_NC
 .bt_controller_ramdump_section (ORIGIN(FLASH_NC) + LENGTH(FLASH_NC) - 0x1000 - 0x1000 -
  0 - 0x1000*2 - 0x1000 -
  0 - 0 - 0 -
  0 - 0 - 0) (NOLOAD) :
 {
  __bt_controller_ramdump_section_start = .;
  . = 0;
  __bt_controller_ramdump_section_end = .;
 } > FLASH_NC
 .coredump_section (ORIGIN(FLASH_NC) + LENGTH(FLASH_NC) - 0x1000 - 0x1000 -
  0 - 0x1000*2 - 0x1000 -
  0 - 0 - 0 -
  0 - 0) (NOLOAD) :
 {
  __coredump_section_start = .;
  . = 0;
  __coredump_section_end = .;
 } > FLASH_NC
 .ota_upgrade_log (ORIGIN(FLASH_NC) + LENGTH(FLASH_NC) - 0x1000 - 0x1000 -
  0 - 0x1000*2 - 0x1000 -
  0 - 0 - 0 -
  0) (NOLOAD) :
 {
  __ota_upgrade_log_start = .;
  . = 0;
  __ota_upgrade_log_end = .;
 } > FLASH_NC
 .log_dump (ORIGIN(FLASH_NC) + LENGTH(FLASH_NC) - 0x1000 - 0x1000 -
  0 - 0x1000*2 - 0x1000 -
  0 - 0 - 0) (NOLOAD) :
 {
  __log_dump_start = .;
  . = 0;
  __log_dump_end = .;
 } > FLASH_NC
 .crash_dump (ORIGIN(FLASH_NC) + LENGTH(FLASH_NC) - 0x1000 - 0x1000 -
  0 - 0x1000*2 - 0x1000 -
  0 - 0) (NOLOAD) :
 {
  __crash_dump_start = .;
  . = 0;
  __crash_dump_end = .;
 } > FLASH_NC
 .custom_parameter (ORIGIN(FLASH_NC) + LENGTH(FLASH_NC) - 0x1000 - 0x1000 -
  0 - 0x1000*2 - 0x1000 -
  0) (NOLOAD) :
 {
  __custom_parameter_start = .;
  . = 0x1000;
  __custom_parameter_end = .;
 } > FLASH_NC
 .lhdc_license (ORIGIN(FLASH_NC) + LENGTH(FLASH_NC) - 0x1000 - 0x1000 -
  0 - 0x1000*2 - 0x1000) (NOLOAD) :
 {
  __lhdc_license_start = .;
  . = 0;
  __lhdc_license_end = .;
 } > FLASH_NC
 .userdata (ORIGIN(FLASH_NC) + LENGTH(FLASH_NC) - 0x1000 - 0x1000 -
  0 - 0x1000*2) (NOLOAD) :
 {
  __userdata_start = .;
  . = 0x1000*2;
  __userdata_end = .;
 } > FLASH_NC
 .audio (ORIGIN(FLASH_NC) + LENGTH(FLASH_NC) - 0x1000 - 0x1000 -
  0) (NOLOAD) :
 {
  __aud_start = .;
  . = 0;
  __aud_end = .;
 } > FLASH_NC
 .reserved (ORIGIN(FLASH_NC) + LENGTH(FLASH_NC) - 0x1000 - 0x1000) (NOLOAD) :
 {
  __reserved_start = .;
  . = 0x1000;
  __reserved_end = .;
 } > FLASH_NC
 .factory (ORIGIN(FLASH_NC) + LENGTH(FLASH_NC) - 0x1000) (NOLOAD) :
 {
  __factory_start = .;
  . = 0x1000;
  __factory_end = .;
 } > FLASH_NC
 __tail_section_start = __prompt_start;
 ASSERT(((__tail_section_start) - 0x30000000 + 0x34000000) >= __flash_end, "region FLASH overflowed")
 __free_flash = ((__tail_section_start) - 0x30000000 + 0x34000000) - __flash_end;
 ASSERT((__vector_table_start & (1K - 1)) == 0, "vector table alignment error")
 /DISCARD/ :
 {
  *(.interp)
  *(.hash)
  *(.dynsym)
  *(.dynstr)
  *(.gnu.version)
  *(.gnu.version_d)
  *(.gnu.version_r)
  *(.rela.plt)
  *(.rela.data.rel.ro*)
  *(.rela.gnu.linkonce.d.rel.ro*)
  *(.rela.*)
  *(.plt)
  *(.dynamic)
 }
}
