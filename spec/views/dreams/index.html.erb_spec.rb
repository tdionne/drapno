require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/dreams/index.html.erb" do
  include DreamsHelper

  before(:each) do
    assigns[:dreams] = [
      stub_model(Dream),
      stub_model(Dream)
    ]
  end

  it "renders a list of dreams" do
    render
  end
end
