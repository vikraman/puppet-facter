Puppet::Type.newtype(:fact) do

  desc "The fact type to manage /etc/facter/facts.d/$fact.txt"

  ensurable do
    defaultvalues
    defaultto :present
  end

  newparam(:name, :namevar => true) do
    desc "The fact name"
    isnamevar
  end

  newproperty(:content) do
    desc "The value of the fact"
  end

  newproperty(:target) do
    desc "Target txt file to write under /etc/facter/facts.d"
    defaultto { @resource[:name] }
  end

end
