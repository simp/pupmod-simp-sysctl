module Puppet
  newtype(:sysctl_set_value) do
    @doc = "Sets a sysctl value on an actively running system.
            Autorequires sysctl(<name>) if possible"

    newparam(:name) do
      isnamevar
      desc "The sysctl value to set"

      validate do |value|
        if value =~ /\s/ then
          fail Puppet::Error, "Error: Sysctl values cannot have spaces!"
        end
      end

      munge do |value|
        value.downcase
      end
    end

    newproperty(:val) do
      desc "The value to which the item should be set"

      def sync
        provider.activate_sysctl
      end

      def retrieve
        return provider.get_sysctl
      end

      munge do |value|
        value.delete('\"\'').strip.gsub(/\s+/,' ')
      end
    end

    autorequire(:sysctl) do
      self[:name]
    end

    validate do
      required_fields = [:val]

      required_fields.each do |req|
        unless @parameters.include?(req)
          fail Puppet::Error, "You must specify #{req}."
        end
      end
    end

  end
end
