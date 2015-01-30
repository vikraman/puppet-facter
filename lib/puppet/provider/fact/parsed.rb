require 'puppet/provider/parsedfile'

Puppet::Type.type(:fact).provide(:parsed,
  :parent => Puppet::Provider::ParsedFile,
  :default_target => '/etc/facter/facts.d/default.txt',
  :filetype => :flat
) do
  desc "test"

  record_line :parsed, :fields => %w{name value}, :joiner => '='
end
