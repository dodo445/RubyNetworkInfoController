class Interface

  def initialize()
   @name = ""
   @mac_adress = "00:00:00:00:00"
   @ip_adress = "0.0.0.0"

  end
  # Accesors
  def getName()
    @name
  end
  def getMac()
    @mac_adress
  end
  def getIp()
    @ip_adress
  end
  # setter methods
  def setName(name)
    @name = name
  end
  def setMac(mac_adress)
    @mac_adress=mac_adress
  end
  def setIp(ip_adress)
    @ip_adress=ip_adress
  end

end