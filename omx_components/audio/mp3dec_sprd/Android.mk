#
# Copyright (C) 2016 The Android Open Source Project
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

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_SRC_FILES := \
	SPRDMP3Decoder.cpp

LOCAL_CFLAGS := \
	-DOSCL_EXPORT_REF= \
	-DOSCL_IMPORT_REF=

LOCAL_LDFLAGS += \
	-Wl,--no-warn-shared-textrel

LOCAL_SHARED_LIBRARIES := \
	libmedia_omx \
	libstagefright_omx \
	libstagefright_foundation \
	libstagefrighthw \
	libmemoryheapion_sprd \
	libutils \
	libui \
	libdl \
	libcutils \
	liblog \

LOCAL_MODULE := libstagefright_sprd_mp3dec
LOCAL_MODULE_TAGS := optional
LOCAL_PROPRIETARY_MODULE := true

include $(BUILD_SHARED_LIBRARY)
