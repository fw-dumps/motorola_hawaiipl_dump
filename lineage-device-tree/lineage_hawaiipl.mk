#
# Copyright (C) 2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from hawaiipl device
$(call inherit-product, device/motorola/hawaiipl/device.mk)

PRODUCT_DEVICE := hawaiipl
PRODUCT_NAME := lineage_hawaiipl
PRODUCT_BRAND := motorola
PRODUCT_MODEL := moto e32(s)
PRODUCT_MANUFACTURER := motorola

PRODUCT_GMS_CLIENTID_BASE := android-motorola

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="sys_mssi_64_cn-user 12 STB32.36-99-1 99-1 release-keys"

BUILD_FINGERPRINT := motorola/hawaiipl_g/hawaiipl:12/STB32.36-99-1/99-1:user/release-keys
