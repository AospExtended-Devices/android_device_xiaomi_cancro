# Copyright (C) 2014 The CyanogenMod Project
# Copyright (C) 2017 The LineageOS Project
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

# Boot animation
TARGET_SCREEN_HEIGHT := 1920
TARGET_SCREEN_WIDTH := 1080

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common lineage stuff.
$(call inherit-product, vendor/aosp/common.mk)

# Inherit from cancro device
$(call inherit-product, device/xiaomi/cancro/cancro.mk)

PRODUCT_NAME := aosp_cancro
PRODUCT_DEVICE := cancro
PRODUCT_BRAND := Xiaomi
PRODUCT_MANUFACTURER := Xiaomi
PRODUCT_MODEL := MI Cancro

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi

TARGET_CONTINUOUS_SPLASH_ENABLED := true

TARGET_BOOT_ANIMATION_RES := 1080
EXTENDED_BUILD_TYPE=OFFICIAL

# Use the latest approved GMS identifiers unless running a signed build
ifneq ($(SIGN_BUILD),true)
PRODUCT_BUILD_PROP_OVERRIDES += \
    BUILD_FINGERPRINT=Xiaomi/cancro/cancro:6.0.1/MMB29M/V9.2.2.0.MXDMIEX:user/release-keys \
    PRIVATE_BUILD_DESC="cancro-user 6.0.1 MMB29M V9.2.2.0.MXDMIEX release-keys"
endif
