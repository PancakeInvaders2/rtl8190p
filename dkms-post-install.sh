#!/bin/sh
set -eu

FIRMWARE_DIR="/lib/firmware/rtlwifi"

install -d "$FIRMWARE_DIR"

install -m 644 firmware/rtl8190p_boot.img "$FIRMWARE_DIR/rtl8190p_boot.img"
install -m 644 firmware/rtl8190p_main.img "$FIRMWARE_DIR/rtl8190p_main.img"
install -m 644 firmware/rtl8190p_data.img "$FIRMWARE_DIR/rtl8190p_data.img"