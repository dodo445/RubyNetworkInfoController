#!/usr/bin/ruby

require 'colorize'
require 'green_shoes'
require "../Model/interface"
#******************************* command  ``
BEGIN {
}


device = Interface.new()
device.setMac("AA:BB:CC:DD:EE")
device.setIp("127.0.0.1")
device.setName("Wlan0")
