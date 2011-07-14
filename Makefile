THEOS_DEVICE_IP=192.168.1.23
include theos/makefiles/common.mk

TWEAK_NAME = DeleteAllSMS
DeleteAllSMS_FILES = Tweak.xm
DeleteAllSMS_FRAMEWORKS = UIKit CoreGraphics Foundation ChatKit
DeleteAllSMS_PRIVATE_FRAMEWORKS = ChatKit
include $(THEOS_MAKE_PATH)/tweak.mk
