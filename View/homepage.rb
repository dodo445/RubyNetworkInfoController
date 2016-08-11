#!/usr/bin/ruby

load "../Controller/main_worker.rb"
require 'colorize'
require 'green_shoes'


BEGIN {
 }

  def device_info
    @other_devices , @wifi_device = displayDevices()
    info_text=""
    wifi_info=""
    @other_devices.each do |device|
       info_text+="Name: #{device.getName()}\nMac Address: #{device.getMac()}\nIP Address: #{device.getIp()}"
    end
    wifi_info+="Name: #{@wifi_device.getName()}\nMac Address: #{@wifi_device.getMac()}\nIP Address: #{@wifi_device.getIp()}"
    return info_text , wifi_info
  end



Shoes.app {

stack(margin: 24){
    other , wifi = device_info()
    title "Network Controller"
    para strong("Interfaces"), " Controller"
      @other_devices_text = para(other)
      para strong("Wireless"), " Controller"
      @wifi_device_text = para(wifi)
    stack do
    @edit_line = edit_line
    @change_button=button( "CHANGE" ) do
      if @edit_line.text == ""
        `ifconfig #{@wifi_device.getName()} down`
      output= `macchanger -r #{@wifi_device.getName()}`
      `ifconfig #{@wifi_device.getName()} up`
      else
        `ifconfig #{@wifi_device.getName()} down`
       output = `macchanger -m #{@edit_line.text()} #{@wifi_device.getName()}`
        `ifconfig #{@wifi_device.getName()} up`

      end
        unless output.include? ("ERROR")
          alert("ERROR: NO VALID MAC IS ENTERED...")
        else
          alert(output)
        end
          end
      end

  }
Thread.new do
  every 5 do
    other,wifi = device_info
    @wifi_device_text.replace(wifi)
    @other_devices_text.replace(other)
  end
end
}







