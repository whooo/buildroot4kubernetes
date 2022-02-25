################################################################################
#
# kubernetes
#
################################################################################

KUBERNETES_VERSION = 1.23.0
KUBERNETES_SITE = $(call github,kubernetes,kubernetes,v$(KUBERNETES_VERSION))
KUBERNETES_LICENSE = Apache-2.0
KUBERNETES_LICENSE_FILES = LICENSE

define KUBERNETES_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) generated_files
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) all WHAT="$(KUBE_WHAT)" KUBE_BUILD_PLATFORMS="linux/$(GO_GOARCH)"
endef

define KUBERNETES_INSTALL_TARGET_CMDS
        $(INSTALL) -D -m 0755 $(KUBE_INSTALL) $(TARGET_DIR)/usr/bin
endef

define HOST_KUBERNETES_BUILD_CMDS
	HOST_GOARCH=$(shell go env GOARCH)
        $(HOST_MAKE_ENV) $(MAKE) -C $(@D) all WHAT="$(KUBE_HOST_WHAT)" KUBE_BUILD_PLATFORMS="linux/$(HOST_GOARCH)"
endef

define HOST_KUBERNETES_INSTALL_CMDS
        $(INSTALL) -D -m 0755 $(KUBE_HOST_INSTALL) $(HOST_DIR)/usr/bin
endef

ifeq ($(BR2_PACKAGE_KUBERNETES_KUBELET),y)
KUBE_WHAT += cmd/kubelet
KUBE_INSTALL += $(@D)/_output/local/bin/linux/$(GO_GOARCH)/kubelet
endif

ifeq ($(BR2_PACKAGE_KUBERNETES_KUBE_APISERVER),y)
KUBE_WHAT += cmd/kube-apiserver
KUBE_INSTALL += $(@D)/_output/local/bin/linux/$(GO_GOARCH)/kube-apiserver
endif

ifeq ($(BR2_PACKAGE_KUBERNETES_KUBE_CONTROLLER_MANAGER),y)
KUBE_WHAT += cmd/kube-controller-manager
KUBE_INSTALL += $(@D)/_output/local/bin/linux/$(GO_GOARCH)/kube-controller-manager
endif

ifeq ($(BR2_PACKAGE_KUBERNETES_KUBE_SCHEDULER),y)
KUBE_WHAT += cmd/kube-scheduler
KUBE_INSTALL += $(@D)/_output/local/bin/linux/$(GO_GOARCH)/kube-scheduler
endif

ifeq ($(BR2_PACKAGE_KUBERNETES_KUBE_PROXY),y)
KUBE_WHAT += cmd/kube-proxy
KUBE_INSTALL += $(@D)/_output/local/bin/linux/$(GO_GOARCH)/kube-proxy
endif

ifeq ($(BR2_PACKAGE_KUBERNETES_KUBECTL),y)
KUBE_WHAT += cmd/kubectl
KUBE_INSTALL += $(@D)/_output/local/bin/linux/$(GO_GOARCH)/kubectl
endif

ifeq ($(BR2_PACKAGE_KUBERNETES_KUBEADM),y)
KUBE_WHAT += cmd/kubeadm
KUBE_INSTALL += $(@D)/_output/local/bin/linux/$(GO_GOARCH)/kubeadm
endif

ifeq ($(BR2_PACKAGE_HOST_KUBERNETES_KUBEADM),y)
HOST_GOARCH=$(shell go env GOARCH)
KUBE_HOST_WHAT += cmd/kubeadm
KUBE_HOST_INSTALL += $(@D)/_output/local/bin/linux/"$(HOST_GOARCH)"/kubeadm
endif

$(eval $(generic-package))
$(eval $(host-generic-package))
