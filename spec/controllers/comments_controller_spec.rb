require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'mocha/mock'
include Mocha

describe CommentsController do

  describe "GET /comments" do
    before(:each) do
      @listings = double('visible dreams', :paginate => []).as_null_object
      Dream.stubs(:listings).returns(@listings)
    end
    
    it "doesn't require a login" do
      controller.expects(:authenticate).never
      get :index
    end

    it "doesn't load a specific comment" do
      Comment.expects(:find).with(nil).never
      get :index
    end
    
    it "paginates the dream" do
      @listings.expects(:paginate).with(:per_page => 15, :page => controller.params[:page], :order => 'dreams.comments_count DESC',
        :conditions => 'dreams.comments_count > 0').returns([])
      get :index
    end
    
    it "works" do
      get :index
      response.should be_success
    end
  end

end
