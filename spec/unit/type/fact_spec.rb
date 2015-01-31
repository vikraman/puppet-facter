require 'spec_helper'

describe Puppet::Type.type(:fact) do

  describe "when validating attributes" do
    params = [:name]
    properties = [:content, :target]

    params.each do |param|
      it "should have the #{param} param" do
        described_class.attrtype(param).should == :param
      end
    end

    properties.each do |property|
      it "should have the #{property} property" do
        described_class.attrtype(property).should == :property
      end
    end
  end

  describe "when validating content" do
    it { described_class.provider_feature(:content).should_not be_nil }
  end

  describe "when validating target" do
    it { described_class.provider_feature(:target).should be_nil #can be nil
    it "should have :name as default value" do
      #??
    end
  end

  it "should have name as the namevar" do
    described_class.key_attributes.should == [:name]
  end
end
