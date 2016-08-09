#!/usr/bin/ruby

require 'colorize'
require 'green_shoes'
#******************************* command  ``
BEGIN {
}
puts "NETWORK INFO SCRIPT".red

def getInterfaces
  interfaces = `ifconfig | grep MULTICAST | awk '{print $1;}'`
  interfaces=interfaces.split(/\n+/)
  return interfaces
end
def getMac
  mac_address = ` ifconfig | grep Ethernet | awk '{print $2;}'`
  mac_address = mac_address.split(/\n+/)
  return mac_address
end
def displayDevices
    i = 0;
    devices =""
    puts "NETWORK INTERFACES:"
    getInterfaces.each do |interface|
    devices += "#{interface} => #{getMac[i]}\n"
    i=i+1
  end
  return devices
end
Shoes.app(width: 400, height: 200, resizable: false , title: "NETWORK INFO") do
  background "royalblue"

  @devices_text=para(displayDevices,:align => "center",:top => 30,)
  @change_button=button( "REFRESH" ) do
    @devices_text.replace(displayDevices)
  end
  Thread.new do
    while true do
      @devices_text.replace(displayDevices)
      sleep 30
    end
  end
end
