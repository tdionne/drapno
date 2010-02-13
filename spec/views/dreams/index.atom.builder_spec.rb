require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/dreams/index.atom.builder" do
  include DreamsHelper

  before(:each) do
    @dreamer = Dreamer.mock(:name => 'Real Name', :to_s => "Not Dreamer Name", :to_param => 'dream')
    assigns[:dreams] = [
      Dream.mock(:id => 1, :dreamer => @dreamer, :created_at => 2.days.ago),
      Dream.mock(:id => 2, :dreamer => @dreamer, :created_at => 1.day.ago)
    ]
    assigns[:dreams].stubs(:total_pages).returns(1)
  end

  it "doesn't show the dreamer's real name" do
    render
    response.body.should_not match(/Real Name/)
  end
end
