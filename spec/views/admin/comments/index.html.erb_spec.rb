require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/comments/index.html.erb" do
  include Admin::CommentsHelper

  before(:each) do
    @dream = Dream.mock
    assigns[:comments] = [
      Comment.mock(:id => 1, :dream => @dream),
      Comment.mock(:id => 2, :dream => @dream)
    ]
    assigns[:comments].stubs(:total_pages).returns(1)
  end

  it "renders a list of comments" do
    render
  end
end
