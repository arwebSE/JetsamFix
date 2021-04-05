ARCHS = arm64 arm64e
TARGET = iphone:latest:14.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = AAAAAAjetsamfix
$(TWEAK_NAME)_FILES = $(wildcard *.x)
$(TWEAK_NAME)_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

after-stage::
	mkdir -p $(THEOS_STAGING_DIR)/DEBIAN
	cp postinst $(THEOS_STAGING_DIR)/DEBIAN/postinst
	cp postinst $(THEOS_STAGING_DIR)/DEBIAN/postrm

after-install::
	install.exec "killall -9 SpringBoard;"

THEOS_DEVICE_IP = 192.168.1.125
