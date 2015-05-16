Puppet::Type.type(:sysctl_set_value).provide(:set_value) do
  desc "Provider for setting sysctl values on running systems."
  
  commands :sysctl => '/sbin/sysctl'

  def activate_sysctl
    %x{#{command(:sysctl)} #{resource[:name]}='#{resource[:val]}'}
  end

  def get_sysctl
    val = %x{#{command(:sysctl)} -n #{resource[:name]}}
    if val.nil? then
      raise(Puppet::Error,"Error: #{resource[:name]} is an unknown key")
    else
      return val.strip.gsub(/\s+/,' ')
    end
  end
end
