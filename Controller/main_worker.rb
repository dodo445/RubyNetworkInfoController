#!/usr/bin/ruby
require "../Model/interface"
#******************************* command  ``
BEGIN {
  puts "Starting main_worker.rb"
}
#init wlan0 device

$device_wlan = Interface.new()
wlan_name= %x[ifconfig | grep -m 1 'wl' | awk '{print $1}' | sed 's/://g']
$device_wlan.setMac("AA:BB:CC:DD:EE")
$device_wlan.setIp("127.0.0.1")
$device_wlan.setName(wlan_name)
