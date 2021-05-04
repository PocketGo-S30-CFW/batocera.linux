################################################################################
#
# rtl8821ce
#
################################################################################

RTL8821CE_VERSION = 897e7c4c15dd5a0a569745dc223d969a26ff5bfc
RTL8821CE_SITE = $(call github,tomaspinho,rtl8821ce,$(RTL8821CE_VERSION))
RTL8821CE_LICENSE = GPL-2.0
RTL8821CE_LICENSE_FILES = LICENSE

RTL8821CE_MODULE_MAKE_OPTS = \
	CONFIG_RTL8821CE=m \
# batocera: setting KVER breaks top level parallelization
	# KVER=$(LINUX_VERSION_PROBED)
	USER_EXTRA_CFLAGS="-DCONFIG_$(call qstrip,$(BR2_ENDIAN))_ENDIAN \
		-Wno-error"

define RTL8821CE_MAKE_SUBDIR
        (cd $(@D); ln -s . rtl8821ce)
endef

RTL8821CE_PRE_CONFIGURE_HOOKS += RTL8821CE_MAKE_SUBDIR

$(eval $(kernel-module))
$(eval $(generic-package))
