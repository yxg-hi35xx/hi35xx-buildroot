################################################################################
#
# ttxserver
#
################################################################################

TTXSERVER_VERSION = 0.2.0
TTXSERVER_SITE_METHOD = file
TTXSERVER_SITE = $(TOPDIR)/package/yxgtech/ttxserver
TTXSERVER_SOURCE = ttxserver-$(TTXSERVER_VERSION).tar.xz
TTXSERVER_DEPENDENCIES = host-pkgconf wpa_supplicant
TTXSERVER_INSTALL_STAGING = NO
TTXSERVER_LICENSE = GPLv2+
TTXSERVER_LICENSE_FILES = COPYING

define TTXSERVER_INSTALL_INIT_SYSV
	$(INSTALL) -m 0755 -D package/yxgtech/ttxserver/S90ttxnet \
		$(TARGET_DIR)/etc/init.d/S90ttxnet
endef

$(eval $(autotools-package))
