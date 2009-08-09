require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/dreams/show.html.erb" do
  include DreamsHelper
  before(:each) do
    @dreamer = Dreamer.mock(:name => 'Dreamer 1')
    assigns[:dream] = @dream = Dream.mock(:id => 1, :dreamer => @dreamer)
    assigns[:related_dreams] = []
  end

  it "renders attributes in <p>" do
    render
  end
end
