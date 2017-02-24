################################################################################
#
# hii2c
#
################################################################################

HII2C_LICENSE = GPLv2+

define HII2C_BUILD_CMDS
	$(TARGET_CC) $(TARGET_CFLAGS) $(TARGET_LDFLAGS) \
		-o $(@D)/i2c_read package/hii2c/i2c_read.c
	$(TARGET_CC) $(TARGET_CFLAGS) $(TARGET_LDFLAGS) \
		-o $(@D)/i2c_write package/hii2c/i2c_write.c
endef

define HII2C_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 755 $(@D)/i2c_read $(TARGET_DIR)/usr/sbin/i2c_read
	$(INSTALL) -D -m 755 $(@D)/i2c_write $(TARGET_DIR)/usr/sbin/i2c_write
endef

$(eval $(generic-package))
