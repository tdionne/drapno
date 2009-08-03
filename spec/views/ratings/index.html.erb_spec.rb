require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/ratings/index.html.erb" do
  include RatingsHelper

  before(:each) do
    assigns[:dreamer] = Dreamer.mock(:name => "EXAMPLE USER")
    @dream = Dream.mock(:id => '1', :title => 'DREAM')
    assigns[:ratings] = [
      Rating.mock(:dream => @dream),
      Rating.mock(:dream => @dream)
    ]
    assigns[:ratings].stubs(:total_pages).returns(1)
  end

  it "renders a list of ratings" do
    render
  end
end
