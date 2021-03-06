require "rack"
require_relative "spec_helper"
require_relative "../lib/raptor/responders"

describe Raptor::Template do
  include Raptor

  it "raises an error when templates access undefined methods" do
    presenter = Object.new
    File.stub(:new) { StringIO.new("<% undefined_method %>") }

    expect do
      Template.render(presenter, "posts/show.html.erb").render
    end.to raise_error(NameError,
                       /undefined local variable or method `undefined_method'/)
  end

  it "renders the template" do
    presenter = stub("presenter")
    rendered = Template.render(presenter, "with_no_behavior/new.html.erb")
    rendered.strip.should == "<form>New</form>"
  end
end

