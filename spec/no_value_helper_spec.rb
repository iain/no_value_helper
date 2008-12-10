require File.dirname(__FILE__) + '/spec_helper'


class NoValueHelperSpec < Spec::ExampleGroup

  include NoValueHelper

  describe "The show-method" do

    before do
      @no_value = %Q{<em class="no_value">no value</em>}
    end
    
    describe "without a block given" do

      it "should return the first argument, when no other parameters have been given" do
        show("foo").should == "foo"
      end

      it "should pass the first argument to the method given as second argument" do
        show("foo", :first_helper).should == "foo has been modified"
      end

      it "should pass the first argument and all the last arguments to the method given as second argument" do
        show("foo", :second_helper, "bar").should == "foo and bar"
      end

      it "should return 'no value' when the first argument is blank" do
        show("").should == @no_value
      end
      
      it "should ignore further arguments if the first argument is blank" do
        show("", :first_helper).should == @no_value
      end

    end

    describe "with a block given" do

      it "should return the return value of the block" do
        show{"foo"}.should == "foo"
      end

      it "should pass the value of the block to the method given as first argument" do
        show(:first_helper) { "foo" }.should == "foo has been modified"
      end

      it "should pass the value of the block and all the last arguments to the method given as first argument" do
        show(:second_helper, "bar") { "foo" }.should == "foo and bar"
      end

      it "should return 'no value' when the value of the block is blank" do
        show { "" }.should == @no_value
      end

      it "should return 'no value' when the value of the block is blank, ignoring other arguments" do
        show(:first_helper) { "" }.should == @no_value
      end

      it "should return 'no value' when a NoMethodError occurs in the block" do
        show { raise NoMethodError }.should == @no_value
        show { @foo.bar }.should == @no_value
      end

      it "should still raise if another exception raises" do
        lambda { show { raise "something else" } }.should raise_error
      end

    end

    describe "configuration" do

      it "should change the 'no value' string" do
        @@no_value_text = lambda { "was empty" }
        show("").should == "was empty"
      end

      it "should change the check method" do
        @@no_value_check_method = lambda { |value| value.nil? }
        show("").should == ""
      end

      before(:each) do
        @old_no_value_text = @@no_value_text
        @old_no_value_check_method = @@no_value_check_method
      end

      after(:each) do
        @@no_value_text = @old_no_value_text
        @@no_value_check_method = @old_no_value_check_method
      end

    end

  end

  private
    
    def first_helper(value)
      "%s has been modified" % value
    end

    def second_helper(value, arg)
      "%s and %s" % [ value, arg ]
    end

end
