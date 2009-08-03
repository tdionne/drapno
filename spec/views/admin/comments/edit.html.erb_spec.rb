require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/comments/edit.html.erb" do
  include Admin::CommentsHelper

  before(:each) do
    @dream = Dream.mock
    @dreamer = Dreamer.mock
    assigns[:comment] = @comment = Comment.mock(:id => 1, :dream => @dream, :dreamer => @dreamer)
  end

  it "renders the edit comments form" do
    render

    response.should have_tag("form[action=#{admin_comment_path(@comment)}][method=post]") do
    end
  end
end
