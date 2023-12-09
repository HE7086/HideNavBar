#!/system/bin/sh

resetprop ro.com.google.ime.kb_pad_port_b 1.0

while [ "$(getprop sys.boot_completed | tr -d '\r')" != "1" ]; do sleep 1; done
sleep 1
cmd overlay fabricate --target android --name test2 android:dimen/navigation_bar_height 0x05 0x03
cmd overlay enable com.android.shell:test2
cmd overlay fabricate --target android --name test android:dimen/navigation_bar_frame_height 0x05 0x01
cmd overlay enable com.android.shell:test
cmd overlay fabricate --target android --name test3 android:dimen/navigation_bar_gesture_height 0x05 0x9000
cmd overlay enable com.android.shell:test3
cmd overlay fabricate --target com.android.systemui --name test4 com.android.systemui:dimen/navigation_handle_radius 0x05 0x0
cmd overlay fabricate --target com.android.systemui --name test5 com.android.systemui:dimen/navigation_home_handle_width 0x05 0x0
cmd overlay enable com.android.shell:test4
cmd overlay enable com.android.shell:test5
killall com.android.systemui
