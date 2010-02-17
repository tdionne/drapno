require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/comments/edit.html.erb" do
  include Admin::CommentsHelper

  before(:each) do
    @dream = Dream.mock(:title => 'a dream')
    @dreamer = Dreamer.mock(:to_s => 'a dreamer', :to_param => '1')
    assigns[:comment] = @comment = Comment.mock(:id => 1, :dream => @dream, :dreamer => @dreamer)
  end

  it "renders the edit comments form" do
    render

    response.should have_tag("form[action=#{admin_comment_path(@comment)}][method=post]") do
    end
  end
end
