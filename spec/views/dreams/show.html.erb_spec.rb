require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/dreams/show.html.erb" do
  include DreamsHelper
  before(:each) do
    assigns[:dream] = @dream = Dream.mock(:id => 1)
  end

  it "renders attributes in <p>" do
    render
  end
end
