LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_SRC_FILES := \
	SPRDVPXDecoder.cpp

LOCAL_C_INCLUDES := \
	$(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr/include \

LOCAL_ADDITIONAL_DEPENDENCIES += \
	INSTALLED_KERNEL_HEADERS \

LOCAL_CFLAGS := \
	-DOSCL_EXPORT_REF= \
	-DOSCL_IMPORT_REF= \

LOCAL_ARM_MODE := arm

LOCAL_HEADER_LIBRARIES := \
	libgralloc_headers_$(TARGET_BOARD_PLATFORM) \

LOCAL_SHARED_LIBRARIES := \
	libmedia_omx \
	libstagefright_omx \
	libstagefright_foundation \
	libstagefrighthw \
	libmemoryheapion_sprd \
	libutils \
	libui \
	libdl \
	liblog \

LOCAL_MODULE := libstagefright_sprd_vpxdec
LOCAL_MODULE_TAGS := optional
LOCAL_PROPRIETARY_MODULE := true

include $(BUILD_SHARED_LIBRARY)
