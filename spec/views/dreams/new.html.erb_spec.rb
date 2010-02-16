require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/dreams/new.html.erb" do
  include DreamsHelper

  before(:each) do
    assigns[:dream] = Dream.mock { |d| d.as_new_record }
    @dreamer = Dreamer.mock
    template.stubs(:current_user).returns(@dreamer)
  end

  it "renders new dream form" do
    render
    response.should have_tag("form[action=?][method=post]", dreams_path)
  end
  
  it "offers a checkbox to tweet dream if twitter account is enabled" do
    @dreamer.stubs(:twitter).returns(true)
    render
    response.should have_tag('input[type=checkbox][id=dream_tweet_dream]')
  end
  
  it "doesn't offer a checkbox to tweet dream if no twitter account" do
    @dreamer.stubs(:twitter).returns(nil)
    render
    response.should_not have_tag('input[type=checkbox][id=dream_tweet_dream]')
  end
end
