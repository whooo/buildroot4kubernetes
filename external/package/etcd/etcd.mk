################################################################################
#
# etcd
#
################################################################################

ETCD_VERSION = 3.5.2
ETCD_SITE = $(call github,etcd-io,etcd,v$(ETCD_VERSION))
ETCD_LICENSE = Apache-2.0
ETCD_LICENSE_FILES = LICENSE

define ETCD_BUILD_CMDS
	$(TARGET_MAKE_ENV) cd $(@D) ; ./build.sh
endef

define ETCD_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/bin/etcd $(TARGET_DIR)/usr/bin/etcd
	$(INSTALL) -D -m 0755 $(@D)/bin/etcdctl $(TARGET_DIR)/usr/bin/etcdctl
	$(INSTALL) -D -m 0755 $(@D)/bin/etcdctl $(TARGET_DIR)/usr/bin/etcdutl
endef

$(eval $(generic-package))
