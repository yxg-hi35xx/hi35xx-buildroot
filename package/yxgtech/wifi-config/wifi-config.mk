################################################################################
#
# wifi-config
#
################################################################################

WIFI_CONFIG_VERSION = 0.2.4
WIFI_CONFIG_SITE_METHOD = file
WIFI_CONFIG_SITE = $(TOPDIR)/package/yxgtech/wifi-config
WIFI_CONFIG_SOURCE = wifi-config-$(WIFI_CONFIG_VERSION).tar.xz
WIFI_CONFIG_DEPENDENCIES = host-pkgconf wpa_supplicant
WIFI_CONFIG_INSTALL_STAGING = NO
WIFI_CONFIG_LICENSE = GPLv2+
WIFI_CONFIG_LICENSE_FILES = COPYING

define WIFI_CONFIG_INSTALL_INIT_SYSV
	$(INSTALL) -m 0755 -D package/yxgtech/wifi-config/S40wifi \
		$(TARGET_DIR)/etc/init.d/S40wifi
endef

$(eval $(autotools-package))
