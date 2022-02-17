################################################################################
#
# skopeo
#
################################################################################

SKOPEO_VERSION = 1.6.1
SKOPEO_SITE = $(call github,containers,skopeo,v$(SKOPEO_VERSION))
SKOPEO_LICENSE = Apache-2.0
SKOPEO_LICENSE_FILES = LICENSE

define HOST_SKOPEO_BUILD_CMDS
	$(HOST_MAKE_ENV) $(MAKE) DISABLE_CGO=1 -C $(@D) bin/skopeo
endef

define HOST_SKOPEO_INSTALL_CMDS
	$(HOST_MAKE_ENV) $(MAKE) DISABLE_CGO=1 DESTDIR=$(HOST_DIR) PREFIX="/usr" -C $(@D) install-binary
endef

$(eval $(host-generic-package))
