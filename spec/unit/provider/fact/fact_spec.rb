require 'spec_helper'

describe Puppet::Type.type(:fact).provider(:fact) do

  it "should remove empty files" do
    described_class.unlink_empty_files == true
  end

  it "should have a default target of /etc/facter/facts.d/$name.txt" do
    described_class.new(:name => "environment").select_file == "/etc/facter/facts.d/enironment.txt"
  end

  it "should have a target of /etc/facter/facts.d/$target.txt when target is specified" do
    described_class.new(:name => "environment", :target => "env").select_file == "/etc/facter/facts.d/env.txt"
  end

  #it "should remove old entry when changing target"
  #it "should create new entry in non existing target"
  #it "should create append new entry in existing target"
  #it "should not remove target when removing a fact but target is not empty"
  #it "should remove target when removing a fact and target is empty"

  describe "when parsing" do

    props = described_class.parse_file("/etc/facter/facts.d/env.txt", "environment=production")
    prop = props.find { |h| h[:name] == "environment" }

    it "should detect name correctly" do
      prop.should_not be_nil
    end

    it "should detect content correctly" do
      prop.should include(:content => "production")
    end

    it "should detect target correctly" do
      prop.should include(:target => "env")
    end
  end

  describe "when formatting" do

    let(:environment_provider) do
      stub("environment_provider",
           :name => "environment",
           :ensure => :present,
           :content => "production",
           :target => "env"
          )
    end

    let(:environment_content) { described_class.format_file("/etc/facter/facts.d/env.txt", [environment_provider]) }

    it "should write content correctly" do
      environment_content.should == "environment=production\n"
    end

    let(:absent_provider) do
      stub("absent_provider",
           :name => "environment",
           :ensure => :absent,
           :content => "production",
           :target => "env"
          )
    end

    it "should cleanup absent resources" do
      described_class.format_file("/etc/facter/facts.d/env.txt", [absent_provider]).should be_empty
    end


    let(:nonexistent_provider) do
      stub("nonexistent_provider",
           :name => "environment",
           :ensure => :absent,
           :content => "production",
           :target => "environment"
          )
    end

    it "should cleanup nonexistent resources" do
      described_class.format_file("/etc/facter/facts.d/env.txt", [nonexistent_provider]).should be_empty
    end
  end
end
