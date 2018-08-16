LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE_TAGS := optional

LOCAL_C_INCLUDES := \
	hardware/ril/include

LOCAL_SRC_FILES := \
	secril-shim.cpp

LOCAL_SHARED_LIBRARIES := \
	liblog \
	libril \
	libcutils \
	libbinder

#LOCAL_CFLAGS := -Wall -Werror

LOCAL_MODULE := libsecril-shim
LOCAL_VENDOR_MODULE := true

include $(BUILD_SHARED_LIBRARY)
