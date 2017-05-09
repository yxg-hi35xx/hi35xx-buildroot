################################################################################
#
# openRTSP
#
################################################################################

OPENRTSP_DEPENDENCIES = live555
OPENRTSP_LICENSE = GPLv2+

define OPENRTSP_BUILD_CMDS
	$(TARGET_CXX) $(TARGET_CXXFLAGS) $(TARGET_LDFLAGS) \
		-I$(STAGING_DIR)/usr/include/BasicUsageEnvironment \
		-I$(STAGING_DIR)/usr/include/UsageEnvironment \
		-I$(STAGING_DIR)/usr/include/groupsock \
		-I$(STAGING_DIR)/usr/include/liveMedia \
		-lBasicUsageEnvironment -lUsageEnvironment \
		-lgroupsock -lliveMedia \
		package/yxgtech/openrtsp/openRTSP.cpp \
		package/yxgtech/openrtsp/playCommon.cpp \
		-o $(@D)/openRTSP
endef

define OPENRTSP_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 755 $(@D)/openRTSP $(TARGET_DIR)/usr/bin/openRTSP
endef

$(eval $(generic-package))
