require File.dirname(__FILE__) + '/spec_helper'

describe NoValueHelper do
  
  describe "without a block given" do
    it "should return the first argument, when no other parameters have been given"
    it "should pass the first argument to the method given as second argument"
    it "should pass the first argument and all the last arguments to the method given as second argument"
    it "should return 'no value' when the first argument is blank"
    it "should return 'no value' if an NoMethodError occurs in the first argument"
    it "should still raise if another exception raises"
  end

  describe "with a block given" do
    it "should return the return value of the block"
    it "should pass the value of the block to the method given as first argument"
    it "should pass the value of the block and all the last arguments to the method given as first argument"
    it "should return 'no value' when the value of the block is blank"
    it "should return 'no value' when a NoMethodError occurs in the block"
    it "should still raise if another exception raises"
  end

  describe "configuration" do
    it "should change the 'no value' string"
    it "should change the check method"
  end

end
