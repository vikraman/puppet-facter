require 'puppet/provider/parsedfile'

Puppet::Type.type(:fact).provide(:parsed, :parent => Puppet::Provider::ParsedFile, :target => '/etc/facter/facts.d/test', :filetype => :flat) do
  desc "test"

  record_line :parsed, :fields => %w{name value}, :joiner => '=' do |line|
    Puppet::Provider::PortageFile.process_line(line, :fact)
  end
end
