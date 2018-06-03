#
# Copyright (C) 2008 The Android Open Source Project
#
# Copyright (C) 2008 The CyanogenMod Project
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

LOCAL_PATH:= $(call my-dir)

ifneq (,$(filter sc8830 scx15,$(TARGET_BOARD_PLATFORM)))
DEVICE_WITH_GSP := true
endif

ifeq ($(DEVICE_WITH_GSP),true)

include $(CLEAR_VARS)

LOCAL_MODULE := sprd_gsp.$(TARGET_BOARD_PLATFORM)

LOCAL_MODULE_RELATIVE_PATH := hw

LOCAL_SHARED_LIBRARIES := liblog

LOCAL_SRC_FILES := \
	gsp_hal.cpp \

LOCAL_CFLAGS := \
	-DHAL_PIXEL_FORMAT_YCbCr_420_P=0x13 \
	-DHAL_PIXEL_FORMAT_YCbCr_420_SP=0x19 \
	-DGRALLOC_USAGE_OVERLAY_BUFFER=0x01000000 \
	-DGRALLOC_USAGE_VIDEO_BUFFER=0x02000000 \
	-DGRALLOC_USAGE_CAMERA_BUFFER=0x04000000 \

LOCAL_C_INCLUDES += \
	$(LOCAL_PATH)/../../../gralloc/$(TARGET_BOARD_PLATFORM) \
	$(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr/include \

LOCAL_ADDITIONAL_DEPENDENCIES := \
	INSTALLED_KERNEL_HEADERS \

LOCAL_MODULE_TAGS := optional

LOCAL_PROPRIETARY_MODULE := true

include $(BUILD_SHARED_LIBRARY)

endif # DEVICE_WITH_GSP
