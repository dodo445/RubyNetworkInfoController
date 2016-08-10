#!/usr/bin/ruby

load "../Controller/main_worker.rb"
require 'colorize'
require 'green_shoes'


BEGIN {
}




Shoes.app {

  stack(margin: 24){
    title "Network Controller"
    para strong("Wireless Interface"), " Controller"
    para "Name: " , $device_wlan.getName
  }


}


