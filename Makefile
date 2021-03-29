TARGET = iphone:latest:14.0
ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

SUBPROJECTS += Tweak Prefs

include $(THEOS_MAKE_PATH)/aggregate.mk

after-stage::
	mkdir -p $(THEOS_STAGING_DIR)/DEBIAN
	cp postinst $(THEOS_STAGING_DIR)/DEBIAN/postinst
	cp postinst $(THEOS_STAGING_DIR)/DEBIAN/postrm

after-install::
	install.exec "killall -9 SpringBoard;"

THEOS_DEVICE_IP = 192.168.1.125
