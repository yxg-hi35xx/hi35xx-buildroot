################################################################################
#
# tutk-server
#
################################################################################

TUTK_SERVER_VERSION = 0.3.1
TUTK_SERVER_SITE_METHOD = file
TUTK_SERVER_SITE = $(TOPDIR)/package/yxgtech/tutk-server
TUTK_SERVER_SOURCE = tutk-server-$(TUTK_SERVER_VERSION).tar.xz
TUTK_SERVER_DEPENDENCIES = host-pkgconf live555 dbus-cpp
TUTK_SERVER_INSTALL_STAGING = NO
TUTK_SERVER_LICENSE = GPLv2+
TUTK_SERVER_LICENSE_FILES = COPYING

TUTK_SERVER_CONF_OPTS = --with-arch=arm9-hi3518

define TUTK_SERVER_INSTALL_INIT_SYSV
	$(INSTALL) -m 0755 -D package/yxgtech/tutk-server/S90tutk \
		$(TARGET_DIR)/etc/init.d/S90tutk
endef

$(eval $(autotools-package))
