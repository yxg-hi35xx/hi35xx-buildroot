################################################################################
#
# mt7601u
#
################################################################################

MT7601U_VERSION = 64b4683f2e0e297c1a8ee395be2d0bfb23da63f2
MT7601U_SITE = $(call github,hi35xx,mt7601u,$(MT7601U_VERSION))
MT7601U_LICENSE = GPLv2
MT7601U_LICENSE_FILES = COPYING
MT7601U_DEPENDENCIES = linux

MT7601U_MAKE_OPTS = PLATFORM=HISILICON
MT7601U_MAKE_OPTS += LINUX_SRC=$(LINUX_DIR)
MT7601U_MAKE_OPTS += ARCH=$(KERNEL_ARCH)
MT7601U_MAKE_OPTS += CROSS_COMPILE=$(TARGET_CROSS)

TARGET_INSTALL_MOD_PATH = /lib/modules/$(LINUX_VERSION_PROBED)/extra

define MT7601U_BUILD_CMDS
	$(LINUX_MAKE_ENV) $(MAKE) -C $(@D) $(MT7601U_MAKE_OPTS)
endef

define MT7601U_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 664 $(@D)/os/linux/mtprealloc.ko \
		$(TARGET_DIR)$(TARGET_INSTALL_MOD_PATH)/mtprealloc.ko
	$(INSTALL) -D -m 664 $(@D)/os/linux/mt7601Usta.ko \
		$(TARGET_DIR)$(TARGET_INSTALL_MOD_PATH)/mt7601Usta.ko
	$(TARGET_CROSS)strip -g --strip-unneeded \
		$(TARGET_DIR)$(TARGET_INSTALL_MOD_PATH)/mtprealloc.ko
	$(TARGET_CROSS)strip -g --strip-unneeded \
		$(TARGET_DIR)$(TARGET_INSTALL_MOD_PATH)/mt7601Usta.ko
	$(HOST_DIR)/sbin/depmod -a -b $(TARGET_DIR) $(LINUX_VERSION_PROBED)
	$(INSTALL) -D -m 644 $(@D)/MT7601USTA.dat \
		$(TARGET_DIR)/etc/Wireless/RT2870STA/MT7601USTA.dat
endef

$(eval $(generic-package))
