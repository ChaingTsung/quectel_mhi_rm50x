#
# Copyright (C) 2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=quectel_pcie_mhi
PKG_VERSION:=3.2
PKG_RELEASE:=1

include $(INCLUDE_DIR)/kernel.mk
include $(INCLUDE_DIR)/package.mk

define KernelPackage/quectel_pcie_mhi
  SUBMENU:=WWAN Support
  TITLE:=Kernel pcie driver for quectel RM50X Series MHI device
  DEPENDS:=+pciids +pciutils +quectel-CM-5G +Quectel_QConnectManager
  FILES:=$(PKG_BUILD_DIR)/quectel_pcie_mhi.ko
  AUTOLOAD:=$(call AutoLoad,90,quectel_pcie_mhi)
endef

define KernelPackage/quectel_pcie_mhi/description
  Kernel module for register a  pciemhi for quectel RM50x series platform device.
endef

MAKE_OPTS:= \
	ARCH="$(LINUX_KARCH)" \
	CROSS_COMPILE="$(TARGET_CROSS)" \
	CXXFLAGS="$(TARGET_CXXFLAGS)" \
	M="$(PKG_BUILD_DIR)" \
	$(EXTRA_KCONFIG)

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) ./src/* $(PKG_BUILD_DIR)/
endef

define Build/Compile
	$(MAKE) -C "$(LINUX_DIR)" \
		$(MAKE_OPTS) \
		modules
endef

$(eval $(call KernelPackage,quectel_pcie_mhi))
