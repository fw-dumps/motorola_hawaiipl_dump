#
# Copyright (C) 2023 The Android Open Source Project
# Copyright (C) 2023 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Omni stuff.
$(call inherit-product, vendor/omni/config/common.mk)

# Inherit from hawaiipl device
$(call inherit-product, device/motorola/hawaiipl/device.mk)

PRODUCT_DEVICE := hawaiipl
PRODUCT_NAME := omni_hawaiipl
PRODUCT_BRAND := motorola
PRODUCT_MODEL := moto e32(s)
PRODUCT_MANUFACTURER := motorola

PRODUCT_GMS_CLIENTID_BASE := android-motorola

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="vnd_p410ae-user 12 STB32.36-99-1 99-1 release-keys"

BUILD_FINGERPRINT := motorola/hawaiipl_g/hawaiipl:12/STB32.36-99-1/99-1:user/release-keys
