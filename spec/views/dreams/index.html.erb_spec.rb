require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/dreams/index.html.erb" do
  include DreamsHelper

  before(:each) do
    @dreamer = Dreamer.mock(:name => 'Dreamer')
    assigns[:dreams] = [
      Dream.mock(:id => 1, :dreamer => @dreamer),
      Dream.mock(:id => 2, :dreamer => @dreamer)
    ]
  end

  it "renders a list of dreams" do
    render
  end
end
