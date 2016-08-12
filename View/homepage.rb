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



Shoes.app(width:500,title:"NetworkController") {

stack(margin: 24) {
    other , wifi = device_info()
       para strong("Interfaces"), " Controller"
      @other_devices_text = para(other)
      para strong("Wireless"), " Controller"
      @wifi_device_text = para(wifi)
    stack do

    @edit_line = edit_line
    @change_button=button( "CHANGE" ) do

      if @edit_line.text == ""
        `ifconfig #{@wifi_device.getName()} down`
      output= `macchanger -r #{@wifi_device.getName()} 2>&1`
      `ifconfig #{@wifi_device.getName()} up`
      else
        m1 = /^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$/.match(@edit_line.text()).class.to_s

        if (m1.include? "Match")
          `ifconfig #{@wifi_device.getName()} down`
       output = `macchanger -m #{@edit_line.text()} #{@wifi_device.getName()} 2>&1`
        `ifconfig #{@wifi_device.getName()} up`
          @wifi_device_text.replace(wifi)
        else
          output = "NO VALID MAC IS ENTERED"
        end
        alert(output)
      end
    end
      @reset_button=button("RESET",margin_left:75,margin_top:-29) do

        `ifconfig #{@wifi_device.getName()} down`
        output= `macchanger -p #{@wifi_device.getName()} 2>&1`
        `ifconfig #{@wifi_device.getName()} up`
        @wifi_device_text.replace(wifi)
        alert(output)
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


END  {

  }




