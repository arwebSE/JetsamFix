TARGET = iphone:latest:13.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = AAAAAAjetsamfix

ARCHS = arm64 arm64e

AAAAAAjetsamfix_FILES = Tweak.x
AAAAAAjetsamfix_CFLAGS = -fobjc-arc
#AAAAAAjetsamfix_FRAMEWORKS = CoreFoundation

include $(THEOS_MAKE_PATH)/tweak.mk

after-stage::
	mkdir -p $(THEOS_STAGING_DIR)/DEBIAN
	cp postinst $(THEOS_STAGING_DIR)/DEBIAN/postinst
	cp postinst $(THEOS_STAGING_DIR)/DEBIAN/postrm

after-install::
	install.exec "killall -9 SpringBoard;"

THEOS_DEVICE_IP = 192.168.1.125
