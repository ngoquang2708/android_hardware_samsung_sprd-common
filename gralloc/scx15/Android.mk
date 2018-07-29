# 
# Copyright (C) 2010 ARM Limited. All rights reserved.
# 
# Copyright (C) 2008 The Android Open Source Project
#
# Copyright (C) 2016 The CyanogenMod Project
#
# Copyright (C) 2018 The LineageOS Project
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

LOCAL_SHARED_LIBRARIES := \
    liblog \
    libcutils \
    libhardware \
    libion_sprd \
    libsync \
    libGLESv1_CM \

LOCAL_STATIC_LIBRARIES := \
	libarect \

LOCAL_C_INCLUDES := \
    $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr/include/ \

LOCAL_HEADER_LIBRARIES := \
    libnativebase_headers \

LOCAL_ADDITIONAL_DEPENDENCIES := \
    INSTALLED_KERNEL_HEADERS \

LOCAL_CFLAGS := \
    -DLOG_TAG=\"gralloc.$(TARGET_BOARD_PLATFORM)\" \
    -DLOG_NDEBUG=0

ifeq ($(USE_SPRD_DITHER),true)
LOCAL_CFLAGS += -DSPRD_DITHER_ENABLE
LOCAL_SHARED_LIBRARIES += libdither
endif

LOCAL_SRC_FILES := \
    gralloc_module.cpp \
    alloc_device.cpp \
    framebuffer_device.cpp \
    mapper.cpp \

include $(BUILD_SHARED_LIBRARY)

endif
