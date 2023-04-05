#!/bin/bash

cat system/system/system_ext/priv-app/MtkSettings/MtkSettings.apk.* 2>/dev/null >> system/system/system_ext/priv-app/MtkSettings/MtkSettings.apk
rm -f system/system/system_ext/priv-app/MtkSettings/MtkSettings.apk.* 2>/dev/null
cat system/system/system_ext/apex/com.android.vndk.v30.apex.* 2>/dev/null >> system/system/system_ext/apex/com.android.vndk.v30.apex
rm -f system/system/system_ext/apex/com.android.vndk.v30.apex.* 2>/dev/null
cat system/system/priv-app/ApeCamera2_R_P412/ApeCamera2_R_P412.apk.* 2>/dev/null >> system/system/priv-app/ApeCamera2_R_P412/ApeCamera2_R_P412.apk
rm -f system/system/priv-app/ApeCamera2_R_P412/ApeCamera2_R_P412.apk.* 2>/dev/null
cat product/app/Maps/Maps.apk.* 2>/dev/null >> product/app/Maps/Maps.apk
rm -f product/app/Maps/Maps.apk.* 2>/dev/null
cat product/app/Duo/Duo.apk.* 2>/dev/null >> product/app/Duo/Duo.apk
rm -f product/app/Duo/Duo.apk.* 2>/dev/null
cat product/app/TrichromeLibrary/TrichromeLibrary.apk.* 2>/dev/null >> product/app/TrichromeLibrary/TrichromeLibrary.apk
rm -f product/app/TrichromeLibrary/TrichromeLibrary.apk.* 2>/dev/null
cat product/app/YouTube/YouTube.apk.* 2>/dev/null >> product/app/YouTube/YouTube.apk
rm -f product/app/YouTube/YouTube.apk.* 2>/dev/null
cat product/app/WebViewGoogle/WebViewGoogle.apk.* 2>/dev/null >> product/app/WebViewGoogle/WebViewGoogle.apk
rm -f product/app/WebViewGoogle/WebViewGoogle.apk.* 2>/dev/null
cat product/app/Gmail2/Gmail2.apk.* 2>/dev/null >> product/app/Gmail2/Gmail2.apk
rm -f product/app/Gmail2/Gmail2.apk.* 2>/dev/null
cat product/app/Photos/Photos.apk.* 2>/dev/null >> product/app/Photos/Photos.apk
rm -f product/app/Photos/Photos.apk.* 2>/dev/null
cat product/app/LatinImeGoogle/LatinImeGoogle.apk.* 2>/dev/null >> product/app/LatinImeGoogle/LatinImeGoogle.apk
rm -f product/app/LatinImeGoogle/LatinImeGoogle.apk.* 2>/dev/null
cat product/priv-app/Messages/Messages.apk.* 2>/dev/null >> product/priv-app/Messages/Messages.apk
rm -f product/priv-app/Messages/Messages.apk.* 2>/dev/null
cat product/priv-app/GmsCore/GmsCore.apk.* 2>/dev/null >> product/priv-app/GmsCore/GmsCore.apk
rm -f product/priv-app/GmsCore/GmsCore.apk.* 2>/dev/null
cat product/priv-app/Velvet/Velvet.apk.* 2>/dev/null >> product/priv-app/Velvet/Velvet.apk
rm -f product/priv-app/Velvet/Velvet.apk.* 2>/dev/null
