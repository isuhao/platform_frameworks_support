# Copyright (C) 2016 The Android Open Source Project
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

LOCAL_PATH := $(call my-dir)

# Here is a prebuilt library containing all the wearable stubs necessary for ambient mode
include $(CLEAR_VARS)
LOCAL_PREBUILT_STATIC_JAVA_LIBRARIES := \
        prebuilt-com.google.android.wearable-stubs:wear_stubs/com.google.android.wearable-stubs.jar
include $(BUILD_MULTI_PREBUILT)

# Here is the final static library that apps can link against.
# Applications that use this library must specify
#
#   LOCAL_STATIC_ANDROID_LIBRARIES := \
#       android-support-wear \
#       android-support-core-ui \
#       android-support-v7-recyclerview
#
# in their makefiles to include the resources and their dependencies in their package

include $(CLEAR_VARS)
LOCAL_USE_AAPT2 := true
LOCAL_AAPT2_ONLY := true
LOCAL_MODULE := android-support-wear
LOCAL_SDK_VERSION := $(SUPPORT_CURRENT_SDK_VERSION)
LOCAL_SRC_FILES := $(call all-java-files-under,src/main/java)
LOCAL_MANIFEST_FILE := src/main/AndroidManifest.xml
LOCAL_RESOURCE_DIR := $(LOCAL_PATH)/res
LOCAL_SHARED_ANDROID_LIBRARIES := \
        android-support-core-ui \
        android-support-annotations \
        android-support-percent \
        android-support-v7-recyclerview \
        android-support-v4
LOCAL_STATIC_JAVA_LIBRARIES := \
        prebuilt-com.google.android.wearable-stubs
LOCAL_JAR_EXCLUDE_FILES := none
LOCAL_JAVA_LANGUAGE_VERSION := 1.7
LOCAL_AAPT_FLAGS := --add-javadoc-annotation doconly
include $(BUILD_STATIC_JAVA_LIBRARY)

