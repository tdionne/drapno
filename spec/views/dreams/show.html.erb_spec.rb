require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/dreams/show.html.erb" do
  include DreamsHelper
  before(:each) do
    @dreamer = Dreamer.mock(:name => 'Dreamer 1', :id => 1, :to_s => 'Dreamer 1')
    @other_dreamer = Dreamer.mock(:name => 'Dreamer 2', :id => 2, :to_s => 'Dreamer 2')
    template.stubs(:signed_in?).returns(true)
    template.stubs(:current_dreamer).returns(@other_dreamer)
    assigns[:dream] = @dream = Dream.mock(:id => 1, :dreamer => @dreamer, :title => 'title', :story => 'story', :to_s => 'title')
    assigns[:related_dreams] = []
  end
  
  it "includes the rating form" do
    render
    response.body.should have_tag("form[class=new_rating]")
  end
  
  it "doesn't include the rating form if this user is the dreamer" do
    template.stubs(:current_dreamer).returns(@dreamer)
    render
    response.body.should_not have_tag("form[class=new_rating]")
  end
end
