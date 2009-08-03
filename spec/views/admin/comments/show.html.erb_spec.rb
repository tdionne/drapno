require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/comments/show.html.erb" do
  include Admin::CommentsHelper
  
  before(:each) do
    assigns[:comment] = @comment = Comment.mock(:id => 1)
  end

  it "renders attributes in <p>" do
    render
  end
end
