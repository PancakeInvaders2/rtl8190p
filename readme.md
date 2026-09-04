# RTL8190P Linux driver

This repository contains the Realtek RTL8190P Linux driver, updated to build and run on modern Linux kernels.

The original driver dates from 2008–2010 and relies on APIs that have since been removed or changed in the Linux kernel. This version includes compatibility fixes for modern kernels, updates to the build system, and DKMS support.

## Requirements

* Linux kernel with the required kernel headers installed
* `make`
* GCC
* DKMS (recommended)
* An RTL8190P PCI wireless adapter

The driver is known to build on **Linux 7.0.0-30** and **7.0.0-31**, and has been tested with an RTL8190P adapter on Linux 7.0.0-31.

## Installation with DKMS

DKMS is the recommended installation method. It automatically rebuilds and reinstalls the driver when a new kernel is installed.

Clone the repository:

```bash
git clone <repository url>
cd rtl8190p
```

Add the driver to DKMS:

```bash
sudo dkms add .
```

Install the driver for the current kernel:

```bash
sudo dkms install 8190p/1.1
```

Check the installation:

```bash
dkms status
```

The driver should appear as installed for the current kernel:

```text
8190p/1.1, <kernel-version>, x86_64: installed
```

Once installed, DKMS will automatically rebuild the driver when a new kernel is installed.

### Firmware

The driver requires three firmware files:

* `rtl8190p_boot.img`
* `rtl8190p_main.img`
* `rtl8190p_data.img`

They are included in the `firmware/` directory and are automatically installed to `/lib/firmware/rtlwifi/` by the DKMS post-install script.

## Manual installation

The driver can also be built and installed without DKMS:

```bash
make
sudo make install
```

This installs the kernel module and firmware for the currently running kernel.

To remove a manually installed driver:

```bash
sudo make uninstall
```

DKMS is recommended for normal use because a manually installed kernel module will not automatically be rebuilt when the kernel is updated.

## Loading the driver

The kernel module is named `8190p`:

```bash
sudo modprobe 8190p
```

Check that it is loaded:

```bash
lsmod | grep 8190
```

The driver should automatically bind to a compatible RTL8190P PCI adapter.

## Kernel compatibility

The driver has been updated to build with modern Linux kernels, including Linux 7.0.

The compatibility work includes:

* Compatibility definitions for kernel APIs removed in Linux 7.0.
* Replacement of the removed `del_timer_sync()` API with `timer_delete_sync()`.
* Updates to the Makefile to use modern Kbuild variables.
* DKMS support for automatic rebuilding across kernel updates.
* Automatic installation of the required firmware.

The driver is still based on the original Realtek source and therefore produces compiler warnings. It may also produce kernel diagnostic warnings on some systems. Despite this, it is functional on the hardware tested.

## Development

Build the driver for the currently running kernel:

```bash
make
```

Clean the build:

```bash
make clean
```

The kernel version can be explicitly specified when building for another installed kernel:

```bash
make KVER=7.0.0-30-generic
```

This is also how the driver is built by DKMS.

## License

GPL, as indicated by the original driver source.
