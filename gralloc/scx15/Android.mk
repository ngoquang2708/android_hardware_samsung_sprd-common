# 
# Copyright (C) 2010 ARM Limited. All rights reserved.
# 
# Copyright (C) 2008 The Android Open Source Project
#
# Copyright (C) 2016 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

ifneq ($(TARGET_SIMULATOR),true)

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_PRELINK_MODULE := false

LOCAL_MODULE_RELATIVE_PATH := hw

LOCAL_MODULE := gralloc.$(TARGET_BOARD_PLATFORM)

LOCAL_MODULE_TAGS := optional

LOCAL_PROPRIETARY_MODULE := true

SHARED_MEM_LIBS := \
	libion_sprd \
	libhardware

LOCAL_SHARED_LIBRARIES := \
	liblog \
	libcutils \
	libGLESv1_CM \
	libsync \
	$(SHARED_MEM_LIBS) \

LOCAL_STATIC_LIBRARIES := \
	libarect \
	libgralloc1-adapter \

LOCAL_C_INCLUDES := \
	$(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr/include/ \

LOCAL_HEADER_LIBRARIES := \
	libnativebase_headers \

LOCAL_ADDITIONAL_DEPENDENCIES := \
	INSTALLED_KERNEL_HEADERS \

LOCAL_EXPORT_C_INCLUDE_DIRS := \
	$(LOCAL_PATH) \
	$(LOCAL_C_INCLUDES) \

LOCAL_CFLAGS := \
	-DLOG_TAG=\"gralloc.$(TARGET_BOARD_PLATFORM)\" \
	-DHAL_PIXEL_FORMAT_YCbCr_420_P=0x13 \
	-DHAL_PIXEL_FORMAT_YCbCr_420_SP=0x19 \
	-DGRALLOC_USAGE_OVERLAY_BUFFER=0x01000000 \
	-DGRALLOC_USAGE_VIDEO_BUFFER=0x02000000 \
	-DGRALLOC_USAGE_CAMERA_BUFFER=0x04000000 \

ifeq ($(strip $(USE_UI_OVERLAY)),true)
LOCAL_CFLAGS += -DUSE_UI_OVERLAY
endif

ifneq ($(strip $(TARGET_BUILD_VARIANT)),user)
LOCAL_CFLAGS += -DDUMP_FB
endif

ifeq ($(USE_SPRD_DITHER),true)
LOCAL_CFLAGS += -DSPRD_DITHER_ENABLE
LOCAL_SHARED_LIBRARIES += libdither
endif

ifeq ($(TARGET_USES_GRALLOC1),true)
LOCAL_CFLAGS += -DADVERTISE_GRALLOC1
LOCAL_SHARED_LIBRARIES += libui
endif

LOCAL_SRC_FILES := \
	gralloc_module.cpp \
	alloc_device.cpp \
	framebuffer_device.cpp \
	dump_bmp.cpp \

#LOCAL_CFLAGS += -DMALI_VSYNC_EVENT_REPORT_ENABLE
include $(BUILD_SHARED_LIBRARY)

endif
