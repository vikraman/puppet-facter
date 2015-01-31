require 'spec_helper'

describe Puppet::Type.type(:fact).provider(:fact) do
  it "should have a default target of /etc/facter/facts.d/$name.txt" do
    described_class.target.should == described_class.name
  end
  #it "should remove old entry when changing target"
  #it "should create new entry in non existing target"
  #it "should create append new entry in existing target"
  #it "should not remove target when removing a fact but target is not empty"
  #it "should remove target when removing a fact and target is empty"
end
