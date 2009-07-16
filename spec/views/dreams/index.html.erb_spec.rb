require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/dreams/index.html.erb" do
  include DreamsHelper

  before(:each) do
    @dreamer = Dreamer.mock(:name => 'Dreamer')
    assigns[:dreams] = [
      Dream.mock(:id => 1, :dreamer => @dreamer, :created_at => 2.days.ago),
      Dream.mock(:id => 2, :dreamer => @dreamer, :created_at => 1.day.ago)
    ]
    assigns[:dreams].stubs(:total_pages).returns(1)
  end

  it "renders a list of dreams" do
    render
  end
end
