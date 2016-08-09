#!/usr/bin/ruby

require 'colorize'
require 'green_shoes'
#******************************* command  ``
BEGIN {
}
puts "NETWORK INFO SCRIPT".red
interfaces = `ifconfig | grep MULTICAST | awk '{print $1;}'`
mac_address = ` ifconfig | grep Ethernet | awk '{print $2;}'`
mac_address = mac_address.split(/\n+/)
interfaces=interfaces.split(/\n+/)
i = 0;
devices =""
puts "NETWORK INTERFACES:"
interfaces.each do |interface|
  devices += "#{interface} => #{mac_address[i]}\n"
  i=i+1
end

Shoes.app(width: 400, height: 200, resizable: false , title: "NETWORK INFO") do
  background "royalblue"
  stack do
    # Background, text and a button: both are elements!
    @back  = background royalblue
    @text  = banner (devices)
    # And so, both can be styled.
    @text.style size: 12, stroke:green, margin: 10, color:red
    @back.style height: 10
  end

end
