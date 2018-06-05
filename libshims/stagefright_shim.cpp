/*
 * Copyright (C) 2018 The LineageOS Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#define LOG_NDEBUG 0
#define LOG_TAG "libstagefright_shim"
#include <utils/Log.h>

#include <system/window.h>

#include <OMX_Component.h>
#include <camera/Camera.h>
#include <camera/CameraParameters.h>
#include <media/stagefright/ACodec.h>
#include <media/stagefright/CameraSource.h>
#include <media/stagefright/SurfaceUtils.h>
#include <media/stagefright/omx/OMXUtils.h>

namespace android
{

status_t ACodec::setupNativeWindowSizeFormatAndUsage(
        ANativeWindow *nativeWindow /* nonnull */, int *finalUsage /* nonnull */,
        bool reconnect) {
    OMX_PARAM_PORTDEFINITIONTYPE def;
    InitOMXParams(&def);
    def.nPortIndex = kPortIndexOutput;

    status_t err = mOMXNode->getParameter(
            OMX_IndexParamPortDefinition, &def, sizeof(def));

    if (err != OK) {
        return err;
    }

    OMX_INDEXTYPE index;
    err = mOMXNode->getExtensionIndex(
            "OMX.google.android.index.AndroidNativeBufferConsumerUsage",
            &index);

    if (err != OK) {
        // allow failure
        err = OK;
    } else {
        int usageBits = 0;
        if (nativeWindow->query(
                nativeWindow,
                NATIVE_WINDOW_CONSUMER_USAGE_BITS,
                &usageBits) == OK) {
            OMX_PARAM_U32TYPE params;
            InitOMXParams(&params);
            params.nPortIndex = kPortIndexOutput;
            params.nU32 = (OMX_U32)usageBits;

            err = mOMXNode->setParameter(index, &params, sizeof(params));

            if (err != OK) {
                ALOGE("Fail to set AndroidNativeBufferConsumerUsage: %d", err);
                return err;
            }
        }
    }

    OMX_U32 usage = 0;
    err = mOMXNode->getGraphicBufferUsage(kPortIndexOutput, &usage);
    if (err != 0) {
        ALOGW("querying usage flags from OMX IL component failed: %d", err);
        // XXX: Currently this error is logged, but not fatal.
        usage = 0;
    }
    int omxUsage = usage;

    if (mFlags & kFlagIsGrallocUsageProtected) {
        usage |= GRALLOC_USAGE_PROTECTED;
    }

    usage |= kVideoGrallocUsage;
    *finalUsage = usage;

    memset(&mLastNativeWindowCrop, 0, sizeof(mLastNativeWindowCrop));
    mLastNativeWindowDataSpace = HAL_DATASPACE_UNKNOWN;

    OMX_COLOR_FORMATTYPE eNativeColorFormat = def.format.video.eColorFormat;
    if (!strcasecmp(mComponentName.c_str(), "OMX.sprd.mpeg4.decoder")
        || !strcasecmp(mComponentName.c_str(), "OMX.sprd.h263.decoder")
        || !strcasecmp(mComponentName.c_str(), "OMX.sprd.h264.decoder")
        || !strcasecmp(mComponentName.c_str(), "OMX.sprd.vpx.decoder")) {
        switch (eNativeColorFormat) {
            case OMX_COLOR_FormatYUV420SemiPlanar:
                eNativeColorFormat = (OMX_COLOR_FORMATTYPE) HAL_PIXEL_FORMAT_YCbCr_420_SP;
                break;
            case OMX_COLOR_FormatYUV420Planar:
            default:
                eNativeColorFormat = (OMX_COLOR_FORMATTYPE) HAL_PIXEL_FORMAT_YCbCr_420_P;
                break;
        }
    }

    ALOGV("gralloc usage: %#x(OMX) => %#x(ACodec)", omxUsage, usage);
    return setNativeWindowSizeFormatAndUsage(
            nativeWindow,
            def.format.video.nFrameWidth,
            def.format.video.nFrameHeight,
            eNativeColorFormat,
            mRotationDegrees,
            usage,
            reconnect);
}

} // namespace android
