#!/usr/bin/ruby
require "../Model/interface"
#******************************* command  ``
BEGIN {
  puts "Starting main_worker.rb"
}
#init wlan0 device

def getInterfaces
  interfaces_name = `ifconfig | grep MULTICAST | awk '{print $1;}'`
  interfaces_name=interfaces_name.split(/\n+/)
  mac = ` ifconfig | grep Ethernet | awk '{print $2;}'`
  mac = mac.split(/\n+/)
  return interfaces_name , mac
end
def displayDevices
  interfaces , mac_adress = getInterfaces()
  i = 0;
  device_list = []
  wifi_list = Interface.new
  interfaces.each do |interface|
    device = Interface.new()
    device.setName(interface.chomp(":"))
    device.setMac(mac_adress[i])
    i=i+1
    if device.getName().include? "wl"
      wifi_list = device
    else
    device_list << device
    end
  end
  return device_list , wifi_list
end

