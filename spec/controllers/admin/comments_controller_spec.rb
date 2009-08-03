require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::CommentsController do
  
  before(:each) do
    @comment = Comment.mock
    Comment.stubs(:find).returns(@comment)
    
    login_as :administrator
    @current_user.stubs(:role).returns('admin')
  end

  describe "GET index" do
    it "assigns all admin_comments as @admin_comments" do
      Comment.stubs(:paginate).returns([@comment])
      get :index
      assigns[:comments].should == [@comment]
    end
  end

  describe "GET edit" do
    it "assigns the requested comments as @comments" do
      Comment.stubs(:find).with("37").returns(@comment)
      get :edit, :id => "37"
      assigns[:comment].should equal(@comment)
    end
  end

  describe "PUT update" do

    describe "with valid params" do
      before(:each) do
        @comment.stubs(:update_attributes).returns(true)
      end
      
      it "updates the requested comments" do
        Comment.expects(:find).with("37").returns(@comment)
        @comment.expects(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :comments => {:these => 'params'}
      end

      it "assigns the requested comments as @comments" do
        put :update, :id => "1"
        assigns[:comment].should equal(@comment)
      end

      it "redirects to the comments" do
        put :update, :id => "1"
        response.should redirect_to(admin_comments_url)
      end
    end

    describe "with invalid params" do
      before(:each) do
        @comment.stubs(:update_attributes).returns(false)
      end
      
      it "updates the requested comments" do
        Comment.expects(:find).with("37").returns(@comment)
        @comment.expects(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :comments => {:these => 'params'}
      end

      it "assigns the comments as @comments" do
        put :update, :id => "1"
        assigns[:comment].should equal(@comment)
      end

      it "re-renders the 'edit' template" do
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    before(:each) do
      @comment.stubs(:destroy).returns(true)
    end
    
    it "destroys the requested comments" do
      Comment.expects(:find).with("37").returns(@comment)
      @comment.expects(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the admin_comments list" do
      Comment.stubs(:find).returns(@comment)
      delete :destroy, :id => "1"
      response.should redirect_to(admin_comments_url)
    end
  end

end
