#!/system/bin/sh
#!/bin/bash

# Copyright (C) 2019 Lenovo Company, Inc.
# All Rights Reserved
# Edited By Rafael Venturini
# Date 03/28/2019

# Please provide implementation for all the functions below.

version=0.1
Default_Delay=5
Default_FM_freq=975
Default_DTV_CHAN=45

#####################################################################
# Function:    BATT_CHARGE_DISABLE                                  #
# Description: This function should force Android to disable the    #
#              phone charging even with USB cable connected.        #
# Note:        Important is to guarantee that not only the charging #
#              icon has changed, but energy is not flowing to       #
#              battery to charge it.                                #
# Inputs:      N/A                                                  #
# Output:      status:     OK/FAIL                                 #
#####################################################################
function BATT_CHARGE_DISABLE
{
    # insert your code below
	echo 0 > /sys/class/power_supply/usb/charge_enabled
    echo "RETURN=PASS"
}


#####################################################################
# Function:    BATT_CHARGE_ENABLE                                   #
# Description: This function should re-enable the phone charging    #
# Inputs:      N/A                                                  #
# Output:      status:     OK/FAIL                                 #
#####################################################################
function BATT_CHARGE_ENABLE
{
    # insert your code below
	echo 1 > /sys/class/power_supply/usb/charge_enabled
    echo "RETURN=PASS"
}

#####################################################################
# Function:    BATT_CURRENT_READ_INSTANT                            #
# Description: This function should provide the real-time current   #
#              flow on the phone battery.                           #
# Note:        It is very important that the current value returned #
#              is as real-time as possible. This function will be   #
#              called multiple times to measure stability           #
# Inputs:      N/A                                                  #
# Output:      OK,[battery current mA]/FAIL                        #
#####################################################################
function BATT_CURRENT_READ_INSTANT
{
    RET=$(cat /sys/class/power_supply/battery/current_now)
    echo $RET
}

#####################################################################
# Function:    BATT_CURRENT_READ_AVERAGE                            #
# Description: This function should provide the average current     #
#              flowing on the phone battery.                        #
# Note:        This value should be updated periodically according  #
#              last current measures                                #
# Inputs:      N/A                                                  #
# Output:      OK,[battery current mA]/FAIL                        #
#####################################################################
function BATT_CURRENT_READ_AVERAGE
{
    RET=$(cat sys/class/power_supply/battery/current_avg)
    echo $RET
}

#####################################################################
# Function:    BATT_BATTERY_THERMISTOR                              #
# Description: This function should provide the battery thermistor  #
#              value in DACs               .                        #
# Note:        This value should be updated periodically            #
# Inputs:      N/A                                                  #
# Output:      OK,[thermistor value]/FAIL                          #
#####################################################################
function BATT_BATTERY_THERMISTOR
{
    RET=$(cat sys/class/power_supply/battery/temp)
    echo $RET
}
##### Read Batt Current - END #####

#####################################################################
# Function:    RETAIL_DEMO_DISABLE                                  #
# Description: disable the battery charging level restriction from  # 
# item 42 to enable charging command works properly,                #
# Note:   after reboot                                              #
# the Battery Charger level must to be limited in 70% again during  #
# charging.                                                         #
#                                                                   #
#                                                                   #
# Inputs:      N/A                                                  #
# Output:      status:     OK/ERROR                                 #
#####################################################################
function RETAIL_DEMO_DISABLE
{
    # insert your code below
	if [ $(getprop sys.retaildemo.enabled) -eq 1 ];then
    setprop sys.retaildemo.enabled 0
    sleep 1
    RETAIL_DEMO_DISABLE="FAIL"
    for i in $(seq 5 -1 1)
    do
    if [ $(getprop sys.retaildemo.enabled) -eq 0 ];then
    RETAIL_DEMO_DISABLE="OK"
    echo "RETURN=PASS"
    break
    else
    echo "wait..."
    fi
    sleep 1
    done
    if [ $RETAIL_DEMO_DISABLE = "FAIL" ];then
    echo "RETURN=ERROR"
	fi
    #echo "feature $0 not implemented"
    else
    echo "CURRENT RETAIL DEMO DISABLE"
	fi
}

#####################################################################
# Function:    RETAIL_DEMO_ENABLE                                  #
# Description: disable the battery charging level restriction from  # 
# item 42 to enable charging command works properly,                #                                                     #
# Note:   after reboot                                              #
# the Battery Charger level must to be limited in 70% again during  #
# charging.                                                         #
#                                                                   #
#                                                                   #
# Inputs:      N/A                                                  #
# Output:      status:     OK/ERROR                                 #
#####################################################################
function RETAIL_DEMO_ENABLE
{
    # insert your code below
	if [ $(getprop sys.retaildemo.enabled) -eq 0 ];then
    setprop sys.retaildemo.enabled 1
    sleep 1
    RETAIL_DEMO_ENABLE="FAIL"
    for i in $(seq 5 -1 1)
    do
    if [ $(getprop sys.retaildemo.enabled) -eq 1 ];then
    RETAIL_DEMO_ENABLE="OK"
    echo "RETURN=PASS"
    break
    else
    echo "wait..."
    fi
    sleep 1
    done
    if [ $RETAIL_DEMO_ENABLE = "FAIL" ];then
    echo "RETURN=ERROR"
	fi
    #echo "feature $0 not implemented"
    else
    echo "CURRENT RETAIL DEMO ENABLE"
	fi
}

#####################################################################
# Function:    BATT_LIMIT_ON                                        #
# Description: Limit the battery charger level in around 70%        #
# Note:   after reboot                                              #
# the Battery Charger level must to be limited in 70% again during  #
# charging.                                                         #
#                                                                   #
#                                                                   #
# Inputs:      N/A                                                  #
# Output:      status:     OK/ERROR                                 #
#####################################################################
function BATT_LIMIT_ON
{
    # insert your code below
    echo 70 > /proc/mtk_battery_cmd/demomode_max_soc
    echo "RETURN=PASS"
}

#####################################################################
# Function:    BATT_LIMIT_OFF                                       #
# Description: Limit the battery charger level in around 70%        #
# Note:   after reboot                                              #
# the Battery Charger level must to be limited in 70% again during  #
# charging.                                                         #
#                                                                   #
#                                                                   #
# Inputs:      N/A                                                  #
# Output:      status:     OK/ERROR                                 #
#####################################################################
function BATT_LIMIT_OFF
{
    # insert your code below
    echo 100 > /proc/mtk_battery_cmd/demomode_max_soc
    echo "RETURN=PASS"
}

#####################################################################
# Function:    SWITCH_TO_BATTERY                                    #
# Description: This function should force the current draw from the #
#              phone Charger Supply to the Battery Power Supply     #
# Inputs:      N/A                                                  #
# Output:      status:     OK/FAIL                                 #
#####################################################################
function SWITCH_TO_BATTERY
{
    # insert your code below
    echo "feature $0 not implemented"
    echo "RETURN=FAIL"
}

#####################################################################
# Function:    SWITCH_TO_BATTERY                                    #
# Description: This function should force the current draw from the #
#              phone Battery Power Supply to the Charger Supply     #
# Inputs:      N/A                                                  #
# Output:      status:     OK/FAIL                                 #
#####################################################################
function SWITCH_TO_ACCESSORY
{
    # insert your code below
    echo "feature $0 not implemented"
    echo "RETURN=FAIL"
}

###################################################################
# Function:    DTV_ON                                             #
# Description: This function should Enable the DTV module         #
#              and sync the default channel                       #
# Note:        no splash screen or prompt box should be required  #
# Inputs:      N/A                                                #
# Output:      status:     OK/FAIL                               #
###################################################################
function DTV_ON
{
    # insert your code below
    echo "feature $0 not implemented"
    echo "RETURN=FAIL"
}

###################################################################
# Function:    DTV_TUNE                                           #
# Description: This function should sync the specified DTV        #
#              channel passed as input on this function call      #
# Inputs:      Desired DTV Channel                                #
# Output:      status:     OK/FAIL                               #
###################################################################
function DTV_TUNE
{
    # takes argument
    # insert your code below
    echo "parameter received: $1"
    echo "feature $0 not implemented"
    echo "RETURN=FAIL"
}

###################################################################
# Function:    DTV_MEAS                                           #
# Description: This function should return the DTV Carrier        #
#              Noise (CN) value for the sync channel              #
# Inputs:      N/A                                                #
# Output:      OK,[DTV CN]/FAIL                                  #
###################################################################
function DTV_MEAS
{
    # insert your code below
    echo "feature $0 not implemented"
    echo "RETURN=FAIL"
}

###################################################################
# Function:    DTV_OFF                                            #
# Description: This function should disable the DTV module        #
# Note:        terminate any DTV process                          #
# Inputs:      N/A                                                #
# Output:      status:     OK/FAIL                               #
###################################################################
function DTV_OFF
{
    # insert your code below
    echo "feature $0 not implemented"
    echo "RETURN=FAIL"
}

###################################################################
# Function:    FM_ON                                              #
# Description: This function should enable the FM module          #
#              and sync default frequency of 97.5Mhz              #
# Note:        no splash screen or prompt box should be required  #
# Inputs:      N/A                                                #
# Output:      status:     OK/FAIL                               #
###################################################################
function FM_ON
{
    # insert your code below
    am start -n com.ape.factory/.CQAtest.CQAActivity -S --es CQA_TEST_MODE FM --es CQA_TEST_FUNCTION FM_ON
    sleep 1
    FM_ON="FAIL"
    for i in $(seq 15 -1 1)
    do
    if [ $(getprop persist.sys.FM_STATE_ON) -eq 1 ];then
    FM_ON="OK"
    echo "RETURN=PASS"
    break
    #else
    #echo "wait..."
    fi
    sleep 1
    done
    if [ $FM_ON = "FAIL" ];then
    echo "RETURN=FAIL"
    echo "feature $0 not implemented"
    fi
  
}

###################################################################
# Function:    FM_TUNE                                            #
# Description: This function should sync a desired freq passed as #
#              input on this function call                        #
# Inputs:      Desired FM freq                                    #
# Output:      status:     OK/FAIL                               #
###################################################################
function FM_TUNE
{
    # takes argument
    # insert your code below
    am start -n com.ape.factory/.CQAtest.CQAActivity -S --es CQA_TEST_MODE FM --es CQA_TEST_FUNCTION FM_TUNE --es CQA_TEST_PARAMS $1
    
    #am broadcast -a com.ape.factory.FM_GETRSSI --es FMtune $1
    sleep 1
    FM_TUNE="FAIL"
    for i in $(seq 3 -1 1)
    do
    if [ $(getprop persist.sys.FM_TuneState) -eq 1 ];then
    echo "parameter received: $1"
    echo "RETURN=PASS"
    FM_TUNE="OK"
    break
    #else
    #echo "wait..."
    fi
    sleep 1
    done
    if [ $FM_TUNE = "FAIL" ];then
    echo "parameter received: $1"
    echo "RETURN=FAIL"
    #echo "feature $0 not implemented"
    fi
}

###################################################################
# Function:    FM_GETRSSI                                         #
# Description: This function should return the FM RSSI            #
# Note:        The RSSI should be updated periodically or on      #
#              every call of function FM_GETRSSI                  #
# Inputs:      N/A                                                #
# Output:      OK,[FM rssi]/FAIL                                 #
###################################################################
function FM_GETRSSI
{
    # insert your code below
    am broadcast -a com.ape.factory.FM_GETRSSI
    sleep 1
    FM_GETRSSI="FAIL"
    for i in $(seq 15 -1 1)
    do
    if [ $(getprop persist.sys.RSSI_VALUE) -ne 0 ];then
    echo "RETURN=PASS,[$(getprop persist.sys.RSSI_VALUE)]"
    FM_GETRSSI="OK"
    break
    #else
    #echo "wait..."
    fi
    sleep 1
    done
    if [ $FM_GETRSSI = "FAIL" ];then
    echo "RETURN=FAIL"
    #echo "feature $0 not implemented"
    fi
}

###################################################################
# Function:    FM_OFF                                             #
# Description: This function should disable the FM module         #
# Note:        terminate any FM process                           #
# Inputs:      N/A                                                #
# Output:      status:     OK/FAIL                               #
###################################################################
function FM_OFF
{
    # insert your code below
    am start -n com.ape.factory/.CQAtest.CQAActivity -S --es CQA_TEST_MODE FM --es CQA_TEST_FUNCTION FM_OFF
    sleep 1
    FM_OFF="FAIL"
    for i in $(seq 15 -1 1)
    do
    if [ $(getprop persist.sys.FM_STATE_OFF) -eq 1 ];then
    FM_OFF="OK"
    echo "RETURN=PASS"
    break
    #else
    #echo "wait..."
    fi
    sleep 1
    done
    if [ $FM_OFF = "FAIL" ];then
    echo "RETURN=FAIL"
    echo "feature $0 not implemented"
    fi
}

###################################################################
# Function:    FM_CHECK                                           #
# Description: This function should check FM (SOC or not.)        #
# Inputs:      N/A                                                #
# Output:      status:     OK/FAIL                               #
###################################################################
function FM_CHECK
{
    sleep 1
    FM_CHECK="FAIL"
    for i in $(seq 6 -1 1)
    do
    if [ $(getprop persist.sys.FTMFM_state) -eq 1 ];then
    echo "RETURN=PASS"
    FM_CHECK="OK"
    break
    #else
    #echo "wait..."
    fi
    sleep 1
    done
    if [ $FM_CHECK = "FAIL" ];then
    echo "RETURN=FAIL"
    fi
}

###################################################################
# Function:    LED_RED                                            #
# Description: This function should enable the RED not. Led       #
# Inputs:      N/A                                                #
# Output:      status:     OK/FAIL                               #
###################################################################
function LED_RED
{
    # insert your code below
    echo "feature $0 not implemented"
    echo "RETURN=FAIL"
}

###################################################################
# Function:    LED_GREEN                                          #
# Description: This function should enable the green not. Led     #
# Inputs:      N/A                                                #
# Output:      status:     OK/FAIL                               #
###################################################################
function LED_GREEN
{
    # insert your code below
    echo "feature $0 not implemented"
    echo "RETURN=FAIL"
}

###################################################################
# Function:    LED_BLUE                                           #
# Description: This function should enable the blue not. Led      #
# Inputs:      N/A                                                #
# Output:      status:     OK/FAIL                               #
###################################################################
function LED_BLUE
{
    # insert your code below
    echo "feature $0 not implemented"
    echo "RETURN=FAIL"
}

###################################################################
# Function:    LED_SOC                                            #
# Description: This function should enable the SOC Led            #
# Inputs:      N/A                                                #
# Output:      status:     OK/FAIL                               #
###################################################################
function LED_SOC
{
    # insert your code below
    echo 1f12 d8 > /sys/devices/platform/1000d000.pwrap/1000d000.pwrap:main_pmic/mt-pmic/pmic_access
    sleep 1
    echo "RETURN=PASS"
}

###################################################################
# Function:    LED_OFF                                            #
# Description: This function should disable all leds (SOC or not.)#
# Inputs:      N/A                                                #
# Output:      status:     OK/FAIL                               #
###################################################################
function LED_OFF
{
    # insert your code below
    echo 1f12 c8 > /sys/devices/platform/1000d000.pwrap/1000d000.pwrap:main_pmic/mt-pmic/pmic_access
    sleep 1
    echo "RETURN=PASS"
}

###################################################################
# Function:    LED_CHECK                                          #
# Description: This function should check leds (SOC or not.)      #
# Inputs:      N/A                                                #
# Output:      status:     OK/FAIL                               #
###################################################################
function LED_CHECK
{
    sleep 1
    LED_CHECK="FAIL"
    RET=$(cat /sys/class/leds/sc27xx:red/brightness)
    for i in $(seq 3 -1 1)
    do
    if [ $RET -eq 255 ];then
    echo "RETURN=PASS"
    LED_CHECK="OK"
    break
    #else
    #echo "wait..."
    fi
    sleep 1
    done
    if [ $LED_CHECK = "FAIL" ];then
    echo "RETURN=FAIL"
    fi
}

####################################################################
# Function:    MIC_1_TOHEADSETRECV_ON                              #
# Description: This function should enable loopback between MIC1   #
#              and headset Receivers.                              #
# Note:        This loopack should be LIVE. It means that it's not #
#              recommended record the MIC and playback on receiver #
#              because this results in delays that is not allowed  #
# Inputs:      N/A                                                 #
# Output:      status:     OK/FAIL                                #
####################################################################
function MIC_1_TOHEADSETRECV_ON
{
    # insert your code below
    #am start -n com.ape.factory/.AuTestActivity -S -e mainmic 10
	am start -n com.ape.factory/.CQAtest.CQAActivity -S --es CQA_TEST_MODE MIC --es CQA_TEST_FUNCTION MIC_1_TOHEADSETRECV_ON
    sleep 0.5
    MIC_1_TOHEADSETRECV_ON="FAIL"
    for i in $(seq 5 -1 1)
    do
    if [ $(getprop vendor.audiohal.mic1_headset_state) -eq 1 ];then
    echo "RETURN=PASS"
    MIC_1_TOHEADSETRECV_ON="OK"
    break
    #else
    #echo "wait..."
    fi
    sleep 1
    done
    if [ $MIC_1_TOHEADSETRECV_ON = "FAIL" ];then
    echo "RETURN=FAIL"
    #echo "feature $0 not implemented"
    fi
}

####################################################################
# Function:    MIC_1_TOHEADSETRECV_OFF                             #
# Description: This function should disable loopback between MIC1  #
#              and headset Receivers.                              #
# Inputs:      N/A                                                 #
# Output:      status:     OK/FAIL                                #
####################################################################
function MIC_1_TOHEADSETRECV_OFF
{
    # insert your code below
    #am start -n com.ape.factory/.AuTestActivity -S -e teststop 1
	am start -n com.ape.factory/.CQAtest.CQAActivity -S --es CQA_TEST_MODE MIC --es CQA_TEST_FUNCTION MIC_1_TOHEADSETRECV_OFF
    sleep 0.5
    MIC_1_TOHEADSETRECV_OFF="FAIL"
    for i in $(seq 5 -1 1)
    do
    if [ $(getprop vendor.audiohal.mic1_headset_state) -eq 0 ];then
    echo "RETURN=PASS"
    MIC_1_TOHEADSETRECV_OFF="OK"
    break
    #else
    #echo "wait..."
    fi
    sleep 1
    done
    if [ $MIC_1_TOHEADSETRECV_OFF = "FAIL" ];then
    echo "RETURN=FAIL"
    #echo "feature $0 not implemented"
    fi
}

####################################################################
# Function:    MIC_2_TOHEADSETRECV_ON                              #
# Description: This function should enable loopback between MIC2   #
#              and headset Receivers.                              #
# Note:        This loopack should be LIVE. It means that it's not #
#              recommended record the MIC and playback on receiver #
#              because this results in delays that is not allowed  #
# Inputs:      N/A                                                 #
# Output:      status:     OK/FAIL                                #
####################################################################
function MIC_2_TOHEADSETRECV_ON
{
    # insert your code below
    echo "feature $0 not implemented"
    echo "RETURN=FAIL"
}

####################################################################
# Function:    MIC_2_TOHEADSETRECV_OFF                             #
# Description: This function should disable loopback between MIC2  #
#              and headset Receivers.                              #
# Inputs:      N/A                                                 #
# Output:      status:     OK/FAIL                                #
####################################################################
function MIC_2_TOHEADSETRECV_OFF
{
    # insert your code below
    echo "feature $0 not implemented"
    echo "RETURN=FAIL"
}

####################################################################
# Function:    AUDIO_CAL                                           #
# Description: This function should perform all audio calibration  #
#              routine if required (in case of use NXP Smart PA    #
#              chipset for example) and return the cal data like   #
#              impedance, temperature, freq or diff                #
# Inputs:      N/A                                                 #
# Output:      OK,[cal data #comma delimited]/FAIL                #
####################################################################
function AUDIO_CAL
{
    # insert your code below
    am start -n com.ape.factory/.CQAtest.CQAActivity --es CQA_TEST_MODE AUDIO --es CQA_TEST_FUNCTION AUDIO_CAL
    sleep 4
    AUDIO_CAL="FAIL"
    for i in $(seq 15 -1 1)
    do
    if [ $(getprop persist.sys.SMART.PA.CALI) -eq 1 ];then
    echo "RETURN=PASS,[$(getprop persist.sys.SMART.PA.DATA)]"
    AUDIO_CAL="OK"
    break
    #else
    #echo "wait..."
    fi
    sleep 1
    done
    if [ $AUDIO_CAL = "FAIL" ];then
    echo "RETURN=FAIL,[$(getprop persist.sys.SMART.PA.DATA)]"
    fi
}

####################################################################
# Function:    AUDIO_CAL_F0                                           #
# Description: This function should perform all audio calibration  #
#              routine if required (in case of use NXP Smart PA    #
#              chipset for example) and return the cal data like   #
#              impedance, temperature, freq or diff                #
# Inputs:      N/A                                                 #
# Output:      OK,[cal data #comma delimited]/FAIL                #
####################################################################
function AUDIO_CAL_F0
{
    # insert your code below
    am start -n com.ape.factory/.CQAtest.CQAActivity --es CQA_TEST_MODE AUDIO --es CQA_TEST_FUNCTION AUDIO_CAL_F0
    sleep 4
    AUDIO_CAL_F0="FAIL"
    for i in $(seq 15 -1 1)
    do
    if [ $(getprop persist.sys.SMART.PA.F0.CALI) -eq 1 ];then
    echo "RETURN=PASS,[$(getprop persist.sys.SMART.PA.F0.DATA)]"
    AUDIO_CAL_F0="OK"
    break
    #else
    #echo "wait..."
    fi
    sleep 1
    done
    if [ $AUDIO_CAL_F0 = "FAIL" ];then
    echo "RETURN=FAIL,[$(getprop persist.sys.SMART.PA.F0.DATA)]"
    fi
}

########################################################################
# Function:    AUDIO_INTERRUPT_LINE                                    #
# Description: This function should check the connection for the       #
#              DSP interrupt line to AP for Always on Voice (AOV Line) #
# Inputs:      N/A                                                     #
# Output:      status:     OK/FAIL                                    #
########################################################################
function AUDIO_INTERRUPT_LINE
{
    # insert your code below
    echo "feature $0 not implemented"
    echo "RETURN=FAIL"
}

####################################################################
# Function:    SENSOR_CAL_ACCEL                                    #
# Description: This function should perform the accell sensor      #
#              calibration if required.                            #
# Inputs:      N/A                                                 #
# Output:      status:     OK/FAIL                                #
####################################################################
function SENSOR_CAL_ACCEL
{
    # insert your code below
    am start -n com.ape.factory/.CQAtest.CQAActivity -S --es CQA_TEST_MODE SENSOR --es CQA_TEST_FUNCTION SENSOR_CAL_ACCEL
    sleep 3
    SENSOR_CAL_ACCEL="FAIL"
    for i in $(seq 6 -1 1)
    do
    if [ $(getprop persist.sys.SENSOR_CAL_ACCEL) -eq 1 ];then
    echo "RETURN=PASS"
    SENSOR_CAL_ACCEL="OK"
    break
    #else
    #echo "wait..."
    fi
    sleep 1
    done
    if [ $SENSOR_CAL_ACCEL = "FAIL" ];then
    echo "RETURN=FAIL"
    #echo "feature $0 not implemented"
    fi
}

####################################################################
# Function:    SENSOR_CAL_GYRO                                     #
# Description: This function should perform the gyroscope sensor   #
#              calibration if required.                            #
# Inputs:      N/A                                                 #
# Output:      status:     OK/FAIL                                #
####################################################################
function SENSOR_CAL_GYRO
{
    # insert your code below
    am start -n com.ape.factory/.CQAtest.CQAActivity -S --es CQA_TEST_MODE SENSOR --es CQA_TEST_FUNCTION SENSOR_CAL_GYRO
    sleep 3
    SENSOR_CAL_GRY="FAIL"
    for i in $(seq 6 -1 1)
    do
    if [ $(getprop persist.sys.SENSOR_CAL_GRY) -eq 1 ];then
    echo "RETURN=PASS"
    SENSOR_CAL_ACCEL="OK"
    break
    #else
    #echo "wait..."
    fi
    sleep 1
    done
    if [ SENSOR_CAL_GRY = "FAIL" ];then
    echo "RETURN=FAIL"
    fi
}

####################################################################
# Function:    SENSOR_CAL_PROXIMITY                                #
# Description: This function should perform the proximity sensor   #
#              calibration if required.                            #
# Note:        If required, this function may be splitted in more  #
#              blocks and receive or not external parameters       #
# Inputs:      any external parameter required                     #
# Output:      status:     OK/FAIL                                #
####################################################################
function SENSOR_CAL_PROXIMITY
{
    # insert your code below
    am start -n com.ape.factory/.CQAtest.CQAActivity -S --es CQA_TEST_MODE SENSOR --es CQA_TEST_FUNCTION SENSOR_CAL_PROXIMITY
    sleep 3
    SENSOR_CAL_PROXIMITY="FAIL"
    for i in $(seq 9 -1 1)
    do
    if [ $(getprop persist.sys.SENSOR_CAL_PROXIMITY) -eq 1 ];then
    echo "RETURN=PASS"
    SENSOR_CAL_PROXIMITY="OK"
    break
    #else
    #echo "wait..."
    fi
    sleep 1
    done
    if [ $SENSOR_CAL_PROXIMITY = "FAIL" ];then
    echo "RETURN=FAIL"
    #echo "feature $0 not implemented"
    fi
}

####################################################################
# Function:    SENSOR_CAL_PROXIMITY_2CM                            #
# Description: This function should perform the proximity sensor   #
#              calibration if required.                            #
# Note:        If required, this function may be splitted in more  #
#              blocks and receive or not external parameters       #
# Inputs:      any external parameter required                     #
# Output:      status:     OK/FAIL                                #
####################################################################
function SENSOR_CAL_PROXIMITY_2CM
{
    # insert your code below
    am start -n com.ape.factory/.CQAtest.CQAActivity -S --es CQA_TEST_MODE SENSOR --es CQA_TEST_FUNCTION SENSOR_CAL_PROXIMITY_2CM
    sleep 3
    SENSOR_CAL_PROXIMITY_2CM="FAIL"
    for i in $(seq 9 -1 1)
    do
    if [ $(getprop persist.sys.SENSOR_CAL_PROXIMITY_2CM) -eq 1 ];then
    echo "RETURN=PASS"
    SENSOR_CAL_PROXIMITY_2CM="OK"
    break
    #else
    #echo "wait..."
    fi
    sleep 1
    done
    if [ SENSOR_CAL_PROXIMITY_2CM = "FAIL" ];then
    echo "RETURN=FAIL"
    #echo "feature $0 not implemented"
    fi
}

####################################################################
# Function:    SENSOR_CAL_PROXIMITY_NOISE                          #
# Description: This function should perform the proximity sensor   #
#              calibration if required.                            #
# Note:        If required, this function may be splitted in more  #
#              blocks and receive or not external parameters       #
# Inputs:      any external parameter required                     #
# Output:      status:     OK/FAIL                                #
####################################################################
function SENSOR_CAL_PROXIMITY_NOISE
{
    # insert your code below
    echo "feature $0 not implemented"
    echo "RETURN=FAIL"
}

####################################################################
# Function:    SENSOR_CAL_PROXIMITY_3M_5M_M                        #
# Description: This function should perform the proximity sensor   #
#              calibration if required.                            #
# Note:        If required, this function may be splitted in more  #
#              blocks and receive or not external parameters       #
# Inputs:      any external parameter required                     #
# Output:      status:     OK/FAIL                                #
####################################################################
function SENSOR_CAL_PROXIMITY_3M_5M_M
{
    # insert your code below
    echo "feature $0 not implemented"
    echo "RETURN=FAIL"
}

####################################################################
# Function:    SENSOR_CAL_PROXIMITY_3M_T                           #
# Description: This function should perform the proximity sensor   #
#              calibration if required.                            #
# Note:        If required, this function may be splitted in more  #
#              blocks and receive or not external parameters       #
# Inputs:      any external parameter required                     #
# Output:      status:     OK/FAIL                                #
####################################################################
function SENSOR_CAL_PROXIMITY_3M_T
{
    # insert your code below
    echo "feature $0 not implemented"
    echo "RETURN=FAIL"
}

####################################################################
# Function:    SENSOR_CAL_PROXIMITY_5M_T                           #
# Description: This function should perform the proximity sensor   #
#              calibration if required.                            #
# Note:        If required, this function may be splitted in more  #
#              blocks and receive or not external parameters       #
# Inputs:      any external parameter required                     #
# Output:      status:     OK/FAIL                                #
####################################################################
function SENSOR_CAL_PROXIMITY_5M_T
{
    # insert your code below
    echo "feature $0 not implemented"
    echo "RETURN=FAIL"
}

####################################################################
# Function:    SENSOR_CAL_ALS                                      #
# Description: This function should perform the ALS sensor         #
#              calibration if required.                            #
# Note:        If required, this function may be splitted in more  #
#              blocks and receive or not external parameters       #
# Inputs:      any external parameter required                     #
# Output:      status:     OK/FAIL                                #
####################################################################
function SENSOR_CAL_ALS
{
    # insert your code below
    am start -n com.ape.factory/.CQAtest.CQAActivity -S --es CQA_TEST_MODE SENSOR --es CQA_TEST_FUNCTION SENSOR_CAL_ALS
    sleep 3
    SENSOR_CAL_LIGHT="FAIL"
    for i in $(seq 9 -1 1)
    do
    if [ $(getprop persist.sys.SENSOR_CAL_LIGHT) -eq 1 ];then
    echo "RETURN=PASS"
    SENSOR_CAL_LIGHT="OK"
    break
    #else
    #echo "wait..."
    fi
    sleep 1
    done
    if [ SENSOR_CAL_LIGHT = "FAIL" ];then
    echo "RETURN=FAIL"
    fi
}

####################################################################
# Function:    LIGHT_SENSOR_TEST_START                                      #
# Description: This function should perform the ALS sensor         #
#              calibration if required.                            #
# Note:        If required, this function may be splitted in more  #
#              blocks and receive or not external parameters       #
# Inputs:      any external parameter required                     #
# Output:      status:     OK/FAIL                                #
####################################################################
function LIGHT_SENSOR_TEST_START
{
    # insert your code below
}

####################################################################
# Function:    GET_LIGHT_SENSOR_VALUE                                      #
# Description: This function should perform the ALS sensor         #
#              calibration if required.                            #
# Note:        If required, this function may be splitted in more  #
#              blocks and receive or not external parameters       #
# Inputs:      any external parameter required                     #
# Output:      status:     OK/FAIL                                #
####################################################################
function GET_LIGHT_SENSOR_VALUE
{
    # insert your code below
    am start -n com.ape.factory/.CQAtest.CQAActivity -S --es CQA_TEST_MODE SENSOR --es CQA_TEST_FUNCTION SENSOR_GET_ALS > /dev/null
    sleep 1
    SENSOR_GET_LIGHT="FAIL"
    for i in $(seq 6 -1 1)
    do
    if [ $(getprop persist.sys.SENSOR_GET_LIGHT) != -1 ];then
    echo "$(getprop persist.sys.SENSOR_GET_LIGHT)"
    SENSOR_GET_LIGHT="OK"
    break
    #else
    #echo "wait..."
    fi
    sleep 1
    done
    if [ SENSOR_GET_LIGHT = "FAIL" ];then
    echo "RETURN=FAIL"
    fi
}
    
####################################################################
# Function:    LIGHT_SENSOR_TEST_STOP                                      #
# Description: This function should perform the ALS sensor         #
#              calibration if required.                            #
# Note:        If required, this function may be splitted in more  #
#              blocks and receive or not external parameters       #
# Inputs:      any external parameter required                     #
# Output:      status:     OK/FAIL                                #
####################################################################
function LIGHT_SENSOR_TEST_STOP
{
    # insert your code below
    am force-stop com.mediatek.sensorhub.ui
    sleep 1
    echo "RETURN=PASS"
   
}
    
####################################################################
# Function:    SENSOR_CAL_LIGHT                                      #
# Description: This function should perform the ALS sensor         #
#              calibration if required.                            #
# Note:        If required, this function may be splitted in more  #
#              blocks and receive or not external parameters       #
# Inputs:      any external parameter required                     #
# Output:      status:     OK/FAIL                                #
####################################################################
function SENSOR_CAL_LIGHT
{
    # insert your code below
    #sleep 3
    #echo $1 > /sys/class/sprd_sensorhub/sensor_hub/light_sensor_calibrator_lux
    #sleep 3
    #echo  2 5 > sys/class/sprd_sensorhub/sensor_hub/light_sensor_calibrator
    #sleep 2
    #echo "RETURN=PASS"
   
}
    
####################################################################
# Function:    WRITE_LSENSOR_DATA_TO_FILE                                      #
# Description: This function should perform the ALS sensor         #
#              calibration if required.                            #
# Note:        If required, this function may be splitted in more  #
#              blocks and receive or not external parameters       #
# Inputs:      any external parameter required                     #
# Output:      status:     OK/FAIL                                #
####################################################################
function WRITE_LSENSOR_DATA_TO_FILE
{
    # insert your code below
    #sleep 3
    #echo  0 5 1 > /sys/class/sprd_sensorhub/sensor_hub/calibrator_cmd
    #sleep 2
    #echo "RETURN=PASS"
   
}

####################################################################
# Function:    SENSOR_CAL_LIGHT                                      #
# Description: This function should perform the ALS sensor         #
#              calibration if required.                            #
# Note:        If required, this function may be splitted in more  #
#              blocks and receive or not external parameters       #
# Inputs:      any external parameter required                     #
# Output:      status:     OK/FAIL                                #
####################################################################
function GET_LIGHT_SENSOR_CALI_DATA
{
    # insert your code below
    am start -n com.ape.factory/.CQAtest.CQAActivity -S --es CQA_TEST_MODE SENSOR --es CQA_TEST_FUNCTION GET_LIGHT_SENSOR_CALI_DATA
    sleep 1
    GET_LIGHT_SENSOR_CALI_DATA="FAIL"
    for i in $(seq 5 -1 1)
    do
    if [ $(getprop persist.sys.SENSOR_LIGHT_CALI_DATA) != -1 ];then
    echo "RETURN=PASS,[$(getprop persist.sys.SENSOR_LIGHT_CALI_DATA)]"
    GET_LIGHT_SENSOR_CALI_DATA="OK"
    break
    #else
    #echo "wait..."
    fi
    sleep 1
    done
    if [ $GET_LIGHT_SENSOR_CALI_DATA = "FAIL" ];then
    echo "RETURN=FAIL"
    fi
}
    
####################################################################
# Function:    SENSOR_CAL_RF                                       #
# Description: This function should perform the calibration of     #
#              antenna capacitive sensor if required.              #
# Note:        If required, this function may be splitted in more  #
#              blocks and receive or not external parameters       #
# Inputs:      any external parameter required                     #
# Output:      status:     OK/FAIL                                #
####################################################################
function SENSOR_CAL_RF
{
    # insert your code below
    echo "feature $0 not implemented"
    echo "RETURN=FAIL"
}

####################################################################
# Function:    SENSOR_PROXIMITY_READ                               #
# Description: This function should return the Proximity sensor    #
#              RAW dataD value                                     #
# Inputs:      N/A                                                 #
# Output:      OK,[Proximity RAW]/FAIL                            #
####################################################################
function SENSOR_PROXIMITY_READ
{
    # insert your code below
    am start -n com.ape.factory/.CQAtest.CQAActivity -S --es CQA_TEST_MODE SENSOR --es CQA_TEST_FUNCTION SENSOR_PROXIMITY_READ
    sleep 1
    SENSOR_PROXIMITY_READ="FAIL"
    for i in $(seq 5 -1 1)
    do
    if [ $(getprop persist.sys.SENSOR_PROXIMITY_READ) -ne -1 ];then
    echo "RETURN=PASS,[$(getprop persist.sys.SENSOR_PROXIMITY_READ)]"
    SENSOR_PROXIMITY_READ="OK"
    break
    #else
    #echo "wait..."
    fi
    sleep 1
    done
    if [ $SENSOR_PROXIMITY_READ = "FAIL" ];then
    echo "RETURN=FAIL"
    fi
}

####################################################################
# Function:    SENSOR_PROXIMITY_READ_2CM                           #
# Description: This function should return the Proximity sensor    #
#              RAW dataN value                                     #
# Inputs:      N/A                                                 #
# Output:      OK,[Proximity RAW]/FAIL                            #
####################################################################
function SENSOR_PROXIMITY_READ_2CM
{
    # insert your code below
    am start -n com.ape.factory/.CQAtest.CQAActivity -S --es CQA_TEST_MODE SENSOR --es CQA_TEST_FUNCTION SENSOR_PROXIMITY_READ_2CM
    sleep 1
    SENSOR_PROXIMITY_READ_2CM="FAIL"
    for i in $(seq 5 -1 1)
    do
    if [ $(getprop persist.sys.SENSOR_PROXIMITY_READ_2CM) -ne -1 ];then
    echo "RETURN=PASS,[$(getprop persist.sys.SENSOR_PROXIMITY_READ_2CM)]"
    SENSOR_PROXIMITY_READ_2CM="OK"
    break
    #else
    #echo "wait..."
    fi
    sleep 1
    done
    if [ $SENSOR_PROXIMITY_READ_2CM = "FAIL" ];then
    echo "RETURN=FAIL"
    fi
}

####################################################################
# Function:    FINGERPRINT_SELFTEST                                #
# Description: This function should perform the selftest of FPS    #
#              sensor.                                             #
# Note:        It should not require finger. Only selftest         #
# Inputs:      N/A                                                 #
# Output:      status:     OK/FAIL                                #
####################################################################
function FINGERPRINT_SELFTEST
{
    # insert your code below
    echo "feature $0 not implemented"
    echo "RETURN=FAIL"
}

######################################################################
# Function:    FINGERPRINT_PRESENCE                                  #
# Description: This function should perform the FPS sensor presence  #
#              detection test and return PRESENCE/ABSENCE according  #
#              status of SENSOR                                      #
# Note:        It should not require real finger, so the image       #
#              quality test may be removed and performed only sensor #
#              interrupt test. This test will be performed using     #
#              capacitive finger without fingerprint only flat rubber#
# Inputs:      N/A                                                   #
# Output:      PRESENCE/ABSENCE                                      #
######################################################################
function FINGERPRINT_PRESENCE
{
    # insert your code below
    setprop persist.sys.power_disable true
    am start -n com.ape.factory/.CQAtest.CQAActivity -S --es CQA_TEST_MODE  FINGERPRINT --es CQA_TEST_FUNCTION FINGERPRINT_PRESENCE
    sleep 2
    FINGERPRINT_PRESENCE="FAIL"
    for i in $(seq 6 -1 1)
    do
    if [ $(getprop persist.sys.FINGERPRINT_PRESENCE) -eq 1 ];then
    echo "RETURN=PASS"
    FINGERPRINT_PRESENCE="OK"
    break
    #else
    #echo "wait..."
    fi
    sleep 1
    done
    if [ $FINGERPRINT_PRESENCE = "FAIL" ];then
    echo "RETURN=FAIL"
    # echo "feature $0 not implemented"
    fi
    setprop persist.sys.power_disable false
}

####################################################################
# Function:    FINGERPRINT_ABSENCE                                 #
# Description: This function should perform the selftest of FPS    #
#              sensor.                                             #
# Note:        It should not require finger. Only selftest         #
# Inputs:      N/A                                                 #
# Output:      status:     OK/FAIL                                #
####################################################################
function FINGERPRINT_ABSENCE
{
    # insert your code below
    echo "feature $0 not implemented"
    echo "RETURN=FAIL"
}

####################################################################
# Function:    FINGERPRINT_CHECK                                   #
# Description: This function should perform the selftest of FPS    #
#              sensor.                                             #
# Note:        It should not require finger. Only selftest         #
# Inputs:      N/A                                                 #
# Output:      status:     OK/FAIL                                #
####################################################################
function FINGERPRINT_CHECK
{
    # insert your code below
    echo "feature $0 not implemented"
    echo "RETURN=FAIL"
}

####################################################################
# Function:    TOUCHPANEL_SELFTEST  		          	           #
# Description: This function should perform the selftest of Touch  #
#			   panel desired by ODM like open, short, relative 	   #
#              capacitance, number of rows and columns			   #
#		 Note: This test should be executed automatically without  #
#			   any operator interaction						       #
# Inputs:      N/A										   		   #
# Output:      status: 	OK/ERROR   						   		   # 
####################################################################
function TOUCHPANEL_SELFTEST
{
	# insert your code below
	IC_NAME="/sys/class/touchscreen/ICNL9911C/" 
    Folder_A="/sys/class/touchscreen/"  
    for file_a in ${Folder_A}*
    do  
      IC_NAME=$file_a  
      echo $IC_NAME  
    done
	RET=$(cat /sys/class/leds/lcd-backlight/brightness)
	if [ $RET -eq 0 ];then
	input keyevent 26
	fi
	sleep 2
	RET=$(cat $IC_NAME/selftest)
	echo $RET
	if [ $RET -eq 1 ];then
	  echo "RETURN=PASS"
	else
	  echo "RETURN=FAIL"
	fi
	sleep 2
}

####################################################################
# Function:    TOUCH_FIRMWARE_UPDATE                               #
# Description: This function should force the TP firmware upgrade  #
# Note:        If desired by ODM, this test can check the Touch    #
#              panel firmware and update only if out of date or    #
#              corrupted, but the response should reflect the      #
#              action like (OK/UPDATED/FAIL)                      #
# Inputs:      N/A                                                 #
# Output:      STATUS: OK/UPDATED/FAIL                            #
####################################################################
function TOUCH_FIRMWARE_UPDATE
{
    # insert your code below
    echo "feature $0 not implemented"
    echo "RETURN=FAIL"
}

####################################################################
# Function:    TOUCHPANEL_VENDOR_ID                                #
# Description: This function should return the touch panel vendor  #
# Inputs:      N/A                                                 #
# Output:      OK,vendor ID/FAIL                                  #
####################################################################
function TOUCHPANEL_VENDOR_ID
{
    # insert your code below
    RET=$(cat /sys/touchscreen/touchscreen_vendor)
    echo $RET
}

####################################################################
# Function:    DISPLAY_VENDOR_ID                                   #
# Description: This function should return the display panel vendor#
# Inputs:      N/A                                                 #
# Output:      OK,vendor ID/FAIL                                  #
####################################################################
function DISPLAY_VENDOR_ID
{
    # insert your code below
    RET=$(cat /sys/devices/platform/product-device-info/info_tp)
	echo $RET
}

####################################################################
# Function:    NFC_SELFTEST                                        #
# Description: This function should perform the NFC selftests to   #
#              verify the overall connectivity and functionality   #
#              of the NFC antenna matching components, the NFC     #
#              antenna, and the SWP line connected to the NFC SIM  #
# Note:        This test requires NFC sim card and may return      #
#              values like antenna AGC and TxLdo in case of antenna#
#              specs evaluation requirement or simply selftest     #
#              result (OK/FAIL)                                   #
# Inputs:      N/A                                                 #
# Output:      OK,[NFC values if desired]/FAIL                    #
####################################################################
function NFC_SELFTEST
{
    # insert your code below
    echo "feature $0 not implemented"
    echo "RETURN=FAIL"
}

####################################################################
# Function:    STAY_AWAKE_ON                                       #
# Description: This function force the phone display to keep       #
#              enabled without timeout                             #
# Note:        Key power button may disable the display normally   #
# Inputs:      N/A                                                 #
# Output:      status:     OK/FAIL                                #
####################################################################
function STAY_AWAKE_ON
{
    # insert your code below
    RET=$(cat /sys/class/leds/lcd-backlight/brightness)
    if [ $RET -eq 0 ];then
    input keyevent 26
	fi
    am start -n com.ape.factory/.CQAtest.CQAActivity -S --es CQA_TEST_MODE STAY_AWAKE --es CQA_TEST_FUNCTION STAY_AWAKE_ON
    sleep 0.3
    echo "RETURN=PASS"
}

####################################################################
# Function:    STAY_AWAKE_OFF                                      #
# Description: This function returns the display timeout to the    #
#              normal status of disable time                       #
# Inputs:      N/A                                                 #
# Output:      status:     OK/FAIL                                #
####################################################################
function STAY_AWAKE_OFF
{
    # insert your code below
    am start -n com.ape.factory/.CQAtest.CQAActivity -S --es CQA_TEST_MODE STAY_AWAKE --es CQA_TEST_FUNCTION STAY_AWAKE_OFF
    sleep 0.3
    RET=$(cat /sys/class/leds/lcd-backlight/brightness)
    if [ $RET -ne 0 ];then
    input keyevent 26
    fi
    echo "RETURN=PASS"
}

####################################################################
# Function:    ENABLE_AUDIO_ENHANCEMENT                            #
# Description: This function should enable any audio enhancement,  #
#              if present, like Dolby Digital                      #
# Note:        No splash screen or operator interaction should be  #
#              required.                                           #
# Inputs:      N/A                                                 #
# Output:      status:     OK/FAIL                                #
####################################################################
function ENABLE_AUDIO_ENHANCEMENT
{
    # insert your code below
    echo "feature $0 not implemented"
    echo "RETURN=FAIL"
}

####################################################################
# Function:    DISABLE_AUDIO_ENHANCEMENT                           #
# Description: This function should disable any audio enhancement, #
#              if present, like Dolby Digital                      #
# Note:        No splash screen or operator interaction should be  #
#              required.                                           #
# Inputs:      N/A                                                 #
# Output:      status:     OK/FAIL                                #
####################################################################
function DISABLE_AUDIO_ENHANCEMENT
{
    # insert your code below
    echo "feature $0 not implemented"
    echo "RETURN=FAIL"
}

####################################################################
# Function:    DISABLE_AIRPLANE                                    #
# Description: This function should disable the airplane mode      #
# Note:        No splash screen or operator interaction should be  #
#              required.                                           #
# Inputs:      N/A                                                 #
# Output:      status:     OK/FAIL                                #
####################################################################
function DISABLE_AIRPLANE
{
    # insert your code below
    am start -n com.ape.factory/.CQAtest.CQAActivity -S --es CQA_TEST_MODE AIRPLANE --es CQA_TEST_FUNCTION DISABLE_AIRPLANE
    sleep 0.3
    echo "RETURN=PASS"
}

####################################################################
# Function:    ENABLE_AIRPLANE                                     #
# Description: This function should enable the airplane mode       #
# Note:        No splash screen or operator interaction should be  #
#              required.                                           #
# Inputs:      N/A                                                 #
# Output:      status:     OK/FAIL                                #
####################################################################
function ENABLE_AIRPLANE
{
    # insert your code below
    am start -n com.ape.factory/.CQAtest.CQAActivity -S --es CQA_TEST_MODE AIRPLANE --es CQA_TEST_FUNCTION ENABLE_AIRPLANE
    sleep 0.3
    echo "RETURN=PASS"
}

####################################################################
# Function:    READ_TRACK_ID                                       #
# Description: This function should return the track_id recorded   #
#              at gsm.serial that matches with ADB Serial ID       #
# Inputs:      N/A                                                 #
# Output:      TRACK_ID                                            #
####################################################################
function READ_TRACK_ID
{
    # insert your code below
    READ_TRACK_ID="FAIL"
    for i in $(seq 5 -1 1)
    do
    if [ $(getprop ro.serial) = "" ];then
    #echo "wait..."
    READ_TRACK_ID="FAIL"
    else
    echo "$(getprop ro.serial)"
    READ_TRACK_ID="OK"
    break
    fi
    sleep 1
    done
    if [ $READ_TRACK_ID = "FAIL" ];then
    echo "RETURN=FAIL"
    #  echo "feature $0 not implemented"
    fi
}

####################################################################
# Function:    READ_EMMC_SIZE                                      #
# Description: This function should return the eMMC capacity       #
# Inputs:      N/A                                                 #
# Output:      OK,EMMC_SIZE [MBytes]/FAIL                         #
####################################################################
function READ_EMMC_SIZE
{
    # insert your code below
    am start -n com.ape.factory/.CQAtest.CQAActivity -S --es CQA_TEST_MODE READ_FLASH --es CQA_TEST_FUNCTION READ_EMMC_SIZE
    sleep 2
    READ_EMMC_SIZE="FAIL"
    for i in $(seq 5 -1 1)
    do
    if [ $(getprop persist.sys.READ_EMMC_SIZE) = "0" ];then
    #echo "wait..."
    READ_EMMC_SIZE="FAIL"
    else
    echo "RETURN=PASS,EMMC_SIZE[$(getprop persist.sys.READ_EMMC_SIZE)]"
    READ_EMMC_SIZE="OK"
    break
    fi
    sleep 1
    done
    if [ $READ_EMMC_SIZE = "FAIL" ];then
    echo "RETURN=FAIL"
    #  echo "feature $0 not implemented"
    fi
}

####################################################################
# Function:    READ_RAM_LPDDR                                      #
# Description: This function should return the RAM capacity        #
# Inputs:      N/A                                                 #
# Output:      OK,RAM_SIZE [MBytes]/FAIL                          #
####################################################################
function READ_RAM_LPDDR
{
    # insert your code below
    am start -n com.ape.factory/.CQAtest.CQAActivity -S --es CQA_TEST_MODE READ_FLASH --es CQA_TEST_FUNCTION READ_RAM_LPDDR
    sleep 2
    READ_RAM_LPDDR="FAIL"
    for i in $(seq 5 -1 1)
    do
    if [ $(getprop persist.sys.READ_RAM_LPDDR) = "0" ];then
    #echo "wait..."
    READ_RAM_LPDDR="FAIL"
    else
    echo "RETURN=PASS,RAM_SIZE[$(getprop persist.sys.READ_RAM_LPDDR)]"
    READ_RAM_LPDDR="OK"
    break
    fi
    sleep 1
    done
    if [ $READ_RAM_LPDDR = "FAIL" ];then
    echo "RETURN=FAIL"
    # echo "feature $0 not implemented"
    fi
}

####################################################################
# Function:    READ_SDCARD_SIZE                                    #
# Description: This function should return the sdcard              #
# Inputs:      N/A                                                 #
# Output:      OK,SDCARD_SIZE [MBytes]/FAIL                       #
####################################################################
function READ_SDCARD_SIZE
{
    # insert your code below
    am start -n com.ape.factory/.CQAtest.CQAActivity -S --es CQA_TEST_MODE READ_FLASH --es CQA_TEST_FUNCTION READ_SDCARD_SIZE
    sleep 2
    READ_SDCARD_SIZE="FAIL"
    for i in $(seq 5 -1 1)
    do
    if [ $(getprop persist.sys.READ_SDCARD_SIZE) = "0" ];then
    #echo "wait..."
    READ_SDCARD_SIZE="FAIL"
    else
    echo "RETURN=PASS,SDCARD_SIZE[$(getprop persist.sys.READ_SDCARD_SIZE)]"
    READ_SDCARD_SIZE="OK"
    break
    fi
    sleep 1
    done
    if [ $READ_SDCARD_SIZE = "FAIL" ];then
    echo "RETURN=FAIL"
    # echo "feature $0 not implemented"
    fi
}
####################################################################
# Function:    FACTORY_RESET                                       #
# Description: This function should force the phone factory reset  #
# Inputs:      N/A                                                 #
# Output:      status:     OK/FAIL                                #
####################################################################
function FACTORY_RESET
{
    # insert your code below
    am start -n com.ape.factory/.CQAtest.CQAActivity -S --es CQA_TEST_MODE  DEVICEINFO --es CQA_TEST_FUNCTION FACTORY_RESET
    #echo "RETURN=PASS"
}

####################################################################
# Function:    VERIFY_FRP_STATE			  		          	       #
# Description: There must be test commands to verify FRP (Factory  #
# Reset Protection) status                                         #
# Inputs:      N/A										   		   #
# Output:      status: 	OK/ERROR   						   		   # 
####################################################################
function VERIFY_FRP_STATE
{
# insert your code below
    am start -n com.ape.factory/.CQAtest.CQAActivity -S --es CQA_TEST_MODE DEVICEINFO --es CQA_TEST_FUNCTION VERIFY_FRP_STATE
    sleep 1
    VERIFY_FRP_STATE="FAIL"
    for i in $(seq 5 -1 1)
    do
    if [ $(getprop persist.sys.VERIFY_FRP_STATE) = "0" ];then
    echo "wait..."
    else	
    echo "RETURN=PASS,VERIFY_FRP_STATE[$(getprop persist.sys.VERIFY_FRP_STATE)]"
    VERIFY_FRP_STATE="OK"
    break
    fi
    sleep 1
    done
    if [ $VERIFY_FRP_STATE = "FAIL" ];then
    echo "RETURN=ERROR"		
   # echo "feature $0 not implemented"		
    fi
}

####################################################################
# Function:    DUAL_CAM_CALIBRATION                                #
# Description: This function should use on dual camera phone       #
# Inputs:      N/A                                                 #
# Output:      status:     OK/FAIL                                #
####################################################################
function DUAL_CAM_CALIBRATION
{
    am start -n com.ape.camfaccalibration/com.ape.camfaccalibration.DualCamCalibration.DualCamVerify --es CQA_TEST_FUNCTION CALIBRATION
    sleep 2
    CALIBRATION_TEST="FAIL"

    for i in $(seq 30 -1 1)
    do

    temp=$(getprop persist.sys.CALIBRATION_TEST)
    echo $temp
    if [ $(getprop persist.sys.CALIBRATION_TEST) -eq 4 ];then
        echo 222
    fi

    echo $(getprop persist.sys.CALIBRATION_TEST)

    if [ $(getprop persist.sys.CALIBRATION_TEST) = "4" ];then
    CALIBRATION_TEST="OK"
    echo "RETURN=PASS"
    break

    elif [ $(getprop persist.sys.CALIBRATION_TEST) = "2" ];then
    CALIBRATION_TEST="FAIL"
    break

    elif [ $(getprop persist.sys.CALIBRATION_TEST) = "1" ];then
    CALIBRATION_TEST="FAIL"
    break

    else	
    echo "wait..."
    fi
    sleep 5
    done

    if [ $CALIBRATION_TEST = "FAIL" ];then
    echo "RETURN=ERROR"		
   # echo "feature $0 not implemented"		
    fi	
}

####################################################################
# Function:    DUAL_CAM_VERIFY                                #
# Description: This function should use on dual camera phone       #
# Inputs:      N/A                                                 #
# Output:      status:     OK/FAIL                                #
####################################################################
function DUAL_CAM_VERIFY
{
    am start -n com.ape.camfaccalibration/com.ape.camfaccalibration.DualCamCalibration.DualCamVerify --es CQA_TEST_FUNCTION VERIFY
    sleep 2
    VERIFY_TEST="FAIL"

    for i in $(seq 12 -1 1)
    do
    if [ $(getprop persist.sys.VERIFY_TEST) = "4" ];then
    VERIFY_TEST="OK"
    echo "RETURN=PASS"
    break

    elif [ $(getprop persist.sys.VERIFY_TEST) = "2" ];then
    VERIFY_TEST="FAIL"
    break

    elif [ $(getprop persist.sys.VERIFY_TEST) = "1" ];then
    VERIFY_TEST="FAIL"
    break

    else	
    echo "wait..."
    fi
    sleep 5
    done

    if [ $VERIFY_TEST = "FAIL" ];then
    echo "RETURN=ERROR"		
   # echo "feature $0 not implemented"		
    fi	
}

####################################################################
# Function:    DUAL_CAM_SAT_CALIBRATION                            #
# Description: This function should use on dual camera phone       #
# Inputs:      N/A                                                 #
# Output:      status:     OK/FAIL                                #
####################################################################
function DUAL_CAM_SAT_CALIBRATION
{
    #am start -n com.sprd.cameracalibration/com.sprd.cameracalibration.itemstest.camera.CameraWTCalibrationActivity --es CQA_TEST_FUNCTION SAT_CALIBRATION
    #sleep 2
    #CALIBRATION_TEST="FAIL"

    #for i in $(seq 30 -1 1)
    #do

    #if [ $(getprop persist.sys.SAT_CALIBRATION_TEST) = "2" ];then
    #CALIBRATION_TEST="OK"
    #echo "RETURN=PASS"
    #break

    #elif [ $(getprop persist.sys.SAT_CALIBRATION_TEST) = "1" ];then
    #CALIBRATION_TEST="FAIL"
    #break

    #else
    #echo "wait..."
    #fi
    #sleep 5
    #done

    #if [ $CALIBRATION_TEST = "FAIL" ];then
    #echo "RETURN=FAIL"
   # echo "feature $0 not implemented"
    #fi
}

####################################################################
# Function:    DUAL_CAM_SAT_VERIFY                                #
# Description: This function should use on dual camera phone       #
# Inputs:      N/A                                                 #
# Output:      status:     OK/FAIL                                #
####################################################################
function DUAL_CAM_SAT_VERIFY
{
    #am start -n com.sprd.cameracalibration/com.sprd.cameracalibration.itemstest.camera.CameraWTVerificationActivity --es CQA_TEST_FUNCTION SAT_VERIFY
    #sleep 2
    #VERIFY_TEST="FAIL"

    #for i in $(seq 12 -1 1)
    #do
    #if [ $(getprop persist.sys.SAT_VERIFY_TEST) = "2" ];then
    #VERIFY_TEST="OK"
    #echo "RETURN=PASS"
    #break

    #elif [ $(getprop persist.sys.SAT_VERIFY_TEST) = "1" ];then
    #VERIFY_TEST="FAIL"
    #break

    #else
    #echo "wait..."
    #fi
    #sleep 5
    #done

    #if [ $VERIFY_TEST = "FAIL" ];then
    #echo "RETURN=FAIL"
   # echo "feature $0 not implemented"
    #fi
}

####################################################################
# Function:    READ_SW_VERSION                                     #
# Description: This function should return the SW_VERSION recorded #
#              at ro.build.description                             #
# Inputs:      N/A                                                 #
# Output:      SW_VERSION                                          #
####################################################################
function READ_SW_VERSION
{
    # insert your code below
    echo "$(getprop ro.build.description)"
    #  echo "feature $0 not implemented"
}

#####################################################################
# Function:    READ_STANDBY_CURRENT                                 #
# Description: This function should provide the real-time current   #
#              flow on the phone battery.                           #
# Note:        It is very important that the current value returned #
#              is as real-time as possible. This function will be   #
#              called multiple times to measure stability           #
# Inputs:      N/A                                                  #
# Output:      OK,[battery current mA]/FAIL                        #
#####################################################################
function READ_STANDBY_CURRENT
{
    # enter airplane
    am start -n com.ape.factory/.CQAtest.CQAActivity -S --es CQA_TEST_MODE AIRPLANE --es CQA_TEST_FUNCTION ENABLE_AIRPLANE
    sleep 0.3
    for i in $(seq 5 -1 1)
    do
    if [ $(getprop persist.sys.AIRPLANE_STATE) -eq 1 ];then
    break
    #else
    #echo "wait..."
    fi
    sleep 1
    done

    # Disable charging
    echo "0" > "/sys/class/power_supply/charger/charge_enabled"

    # turn screen off
    RET=$(cat /sys/class/leds/lcd-backlight/brightness)
    if [ $RET -ne 0 ];then
    input keyevent 26
    fi
    echo "wait 5 seconds ..."
    sleep 5
    # return standby current
    RET=$(cat sys/class/power_supply/battery/current_now)
    echo $RET
}

####################################################################
# Function:    OTG                                                 #
# Description: This function should return the OTG                 #
# Inputs:      N/A                                                 #
# Output:      OK                                                  #
####################################################################
function OTG
{
    # insert your code below
    #am start -n com.ape.factory/.CQAtest.CQAActivity --es CQA_TEST_MODE READ_FLASH --es CQA_TEST_FUNCTION READ_SDCARD_SIZE
    sleep 1
    OTG="FAIL"
    for i in $(seq 2 -1 1)
    do
    if [ $(getprop persist.sys.OTG) = "1" ];then
    echo "RETURN=PASS"
    OTG="OK"
    break
    #else
    #echo "wait..."
    fi
    sleep 1
    done
    if [ $OTG = "FAIL" ];then
    echo "RETURN=FAIL"
    # echo "feature $0 not implemented"
    fi
}

####################################################################
# Function:    ENABLE_CAMERA_FLASH                                 #
# Description: This function should perform the selftest of FPS    #
#              sensor.                                             #
# Note:        It should not require finger. Only selftest         #
# Inputs:      N/A                                                 #
# Output:      status:     OK/FAIL                                #
####################################################################
function ENABLE_CAMERA_FLASH
{
    # insert your code below
    am start -n com.ape.factory/.CQAtest.CQAActivity -S --es CQA_TEST_MODE CAMERA_FLASH --es CQA_TEST_FUNCTION ENABLE_CAMERA_FLASH
    sleep 1
    ENABLE_CAMERA_FLASH="FAIL"
    for i in $(seq 10 -1 1)
    do
    if [ $(getprop persist.sys.CAMERA_FLASH) -eq 1 ];then
    echo "RETURN=PASS"
    ENABLE_CAMERA_FLASH="OK"
    break
    #else
    #echo "wait..."
    fi
    sleep 0.5
    done
    if [ $ENABLE_CAMERA_FLASH = "FAIL" ];then
    echo "RETURN=FAIL"
    # echo "feature $0 not implemented"
    fi
}


####################################################################
# Function:    DISABLE_CAMERA_FLASH                                #
# Description: This function should perform the selftest of FPS    #
#              sensor.                                             #
# Note:        It should not require finger. Only selftest         #
# Inputs:      N/A                                                 #
# Output:      status:     OK/FAIL                                #
####################################################################
function DISABLE_CAMERA_FLASH
{
    # insert your code below
    am start -n com.ape.factory/.CQAtest.CQAActivity -S --es CQA_TEST_MODE CAMERA_FLASH --es CQA_TEST_FUNCTION DISABLE_CAMERA_FLASH
    sleep 1
    DISABLE_CAMERA_FLASH="FAIL"
    for i in $(seq 10 -1 1)
    do
    if [ $(getprop persist.sys.CAMERA_FLASH) -eq 0 ];then
    echo "RETURN=PASS"
    DISABLE_CAMERA_FLASH="OK"
    break
    #else
    #echo "wait..."
    fi
    sleep 0.5
    done
    if [ $DISABLE_CAMERA_FLASH = "FAIL" ];then
    echo "RETURN=FAIL"
    # echo "feature $0 not implemented"
    fi
}

######################################################################
# Function:    SIMCARD_CHECK                                         #
# Description: check the Sim card is inserted or Not                 #
# Note:        N/A                                                   #
# Inputs:      N/A                                                   #
# Output:      PASS/FAIL                                      #
######################################################################
function SIMCARD_CHECK
{
    # insert your code below
    am start -n com.ape.factory/.CQAtest.CQAActivity -S --es CQA_TEST_MODE  SIMCARD --es CQA_TEST_FUNCTION SIMCARD_CHECK
    sleep 1
    SIMCARD_CHECK="FAIL"
    for i in $(seq 6 -1 1)
    do
    if [ $(getprop persist.sys.SIMCARD_CHECK) -eq 1 ];then
    echo "RETURN=PASS"
    SIMCARD_CHECK="OK"
    break
    #else
    #echo "wait..."
    fi
    sleep 1
    done
    if [ $SIMCARD_CHECK = "FAIL" ];then
    echo "RETURN=FAIL"
    fi
}

######################################################################
# Function:    CHECK_SIM_TRAY                                        #
# Description: check the Sim Tray switch                             # 
# Note:        N/A                                                   #
# Inputs:      N/A                                                   #
# Output:      in/out                                      #
######################################################################
function CHECK_SIM_TRAY
{
    # insert your code below
    cat sys/devices/platform/product-device-info/info_sd
}

######################################################################
# Function:    GOOGLEKEY_CHECK                                         #
# Description: check GOOGLEKEY_CHECK                #
# Note:        N/A                                                   #
# Inputs:      N/A                                                   #
# Output:      PASS/FAIL                                      #
######################################################################
function GOOGLEKEY_CHECK
{
echo "$(getprop vendor.googlekey.status)"
}

######################################################################
# Function:    VIDEAINE_CHECK                                         #
# Description: check VIDEAINE_CHECK                                  #
# Note:        N/A                                                   #
# Inputs:      N/A                                                   #
# Output:      PASS/FAIL                                      #
######################################################################
function VIDEAINE_CHECK
{
echo "$(getprop vendor.widevine.status)"
}

####################################################################
# Function:    CLEAR_RUNIN_APPLICATIONS  		          	       #
# Description: to have a quickly procedure to kill runin           #
# application if necessary
#		 Note: It should not require finger. Only selftest 		   #
# Inputs:      N/A										   		   #
# Output:      status: 	OK/ERROR   						   		   # 
####################################################################
function CLEAR_RUNIN_APPLICATIONS
{
	# insert your code below
	am force-stop com.ape.mtbf
    echo "RETURN=PASS"
}

####################################################################
# Function:    CLEAR_CQA_APPLICATIONS                              #
# Description: This function should perform the selftest of FPS    #
#              sensor.                                             #
# Note:        It should not require finger. Only selftest         #
# Inputs:      N/A                                                 #
# Output:      status:     OK/FAIL                                #
####################################################################
function CLEAR_CQA_APPLICATIONS
{
    # insert your code below
    am force-stop com.ape.factory
    am force-stop com.mediatek.engineermode
    am force-stop com.android.fmradio
    echo "RETURN=PASS"
}
##### Main #####
eval $@
