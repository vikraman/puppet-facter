Puppet::Type.newtype(:fact) do

  desc "The fact type to manage /etc/facter.d/facts/$fact.txt"

  ensurable do
    defaultvalues
    defaultto :present
  end

  newparam(:name, :namevar => true) do
    desc "The fact name"
    isnamevar
  end

  newproperty(:value) do
    desc "The value of the fact"
  end
end
