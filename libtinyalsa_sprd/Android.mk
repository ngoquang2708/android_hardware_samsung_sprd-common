LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

ifeq ($(TARGET_TINY_ALSA_IGNORE_SILENCE_SIZE),true)
   LOCAL_CFLAGS += -DIGNORE_SILENCE_SIZE
endif

LOCAL_C_INCLUDES:= external/tinyalsa/include
LOCAL_C_INCLUDES += $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr/include
LOCAL_SRC_FILES:= mixer.c pcm.c
LOCAL_MODULE := libtinyalsa_sprd
LOCAL_SHARED_LIBRARIES:= libcutils libutils
LOCAL_MODULE_TAGS := optional
LOCAL_CFLAGS += -Werror
LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)/include

LOCAL_ADDITIONAL_DEPENDENCIES := $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr

include $(BUILD_SHARED_LIBRARY)

ifeq ($(HOST_OS), linux)
include $(CLEAR_VARS)
LOCAL_C_INCLUDES:= external/tinyalsa/include
LOCAL_C_INCLUDES += $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr/include
LOCAL_SRC_FILES:= mixer.c pcm.c
LOCAL_MODULE := libtinyalsa_sprd
LOCAL_STATIC_LIBRARIES:= libcutils libutils
LOCAL_CFLAGS += -Werror
LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)/include

LOCAL_ADDITIONAL_DEPENDENCIES := $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr

include $(BUILD_HOST_STATIC_LIBRARY)
endif

include $(CLEAR_VARS)
LOCAL_C_INCLUDES:= external/tinyalsa/include
LOCAL_C_INCLUDES += $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr/include
LOCAL_SRC_FILES:= tinyplay.c
LOCAL_MODULE := tinyplay_sprd
LOCAL_SHARED_LIBRARIES:= libcutils libutils libtinyalsa_sprd
LOCAL_MODULE_TAGS := optional
LOCAL_CFLAGS += -Werror -Wno-missing-field-initializers

LOCAL_ADDITIONAL_DEPENDENCIES := $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr

include $(BUILD_EXECUTABLE)

ifeq ($(HOST_OS), linux)
include $(CLEAR_VARS)
LOCAL_C_INCLUDES:= external/tinyalsa/include
LOCAL_C_INCLUDES += $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr/include
LOCAL_SRC_FILES:= tinyplay.c
LOCAL_MODULE := tinyplay_sprd
LOCAL_STATIC_LIBRARIES:= libcutils libutils libtinyalsa_sprd
LOCAL_MODULE_TAGS := optional
LOCAL_CFLAGS += -Werror -Wno-missing-field-initializers

LOCAL_ADDITIONAL_DEPENDENCIES := $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr

include $(BUILD_HOST_EXECUTABLE)
endif

include $(CLEAR_VARS)
LOCAL_C_INCLUDES:= external/tinyalsa/include
LOCAL_C_INCLUDES += $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr/include
LOCAL_SRC_FILES:= tinycap.c
LOCAL_MODULE := tinycap_sprd
LOCAL_SHARED_LIBRARIES:= libcutils libutils libtinyalsa_sprd
LOCAL_MODULE_TAGS := optional
LOCAL_CFLAGS += -Werror -Wno-missing-field-initializers

LOCAL_ADDITIONAL_DEPENDENCIES := $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr

include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)
LOCAL_C_INCLUDES:= external/tinyalsa/include
LOCAL_C_INCLUDES += $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr/include
LOCAL_SRC_FILES:= tinymix.c
LOCAL_MODULE := tinymix_sprd
LOCAL_SHARED_LIBRARIES:= libcutils libutils libtinyalsa_sprd
LOCAL_MODULE_TAGS := optional
LOCAL_CFLAGS += -Werror

LOCAL_ADDITIONAL_DEPENDENCIES := $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr

include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)
LOCAL_C_INCLUDES:= external/tinyalsa/include
LOCAL_C_INCLUDES += $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr/include
LOCAL_SRC_FILES:= tinypcminfo.c
LOCAL_MODULE := tinypcminfo_sprd
LOCAL_SHARED_LIBRARIES:= libcutils libutils libtinyalsa_sprd
LOCAL_MODULE_TAGS := optional
LOCAL_CFLAGS += -Werror

LOCAL_ADDITIONAL_DEPENDENCIES := $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr

include $(BUILD_EXECUTABLE)
