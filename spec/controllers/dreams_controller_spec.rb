require 'rails_helper'

describe DreamsController do
  
  before(:each) do
    login_as :quentin
    @mock_dream = Dream.mock
    @dream_proxy = double('dreams proxy').as_null_object
    @current_user.stubs(:dreams).returns(@dream_proxy)
  end

  describe "GET index" do
    it "assigns a page of dreams as @dreams" do
      Dream.stubs(:paginate).returns([@mock_dream])
      get :index
      assigns[:dreams].should == [@mock_dream]
    end
  end

  describe "GET show" do
    before(:each) do
      @mock_dream.stubs(:find_related_tags).returns([])
    end
    
    it "assigns the requested dream as @dream" do
      Dream.expects(:find).with("37", :include => [:available_comments, {:appearances => :apparition}]).returns(@mock_dream)
      get :show, :id => "37"
      assigns[:dream].should equal(@mock_dream)
    end
  end

  describe "GET new" do
    include Spec::Rails::Matchers
    it "requires a signed in user" do
      controller.should use_before_filter(:authenticate)
    end
    
    it "assigns a new dream as @dream" do
      Dream.stubs(:new).returns(@mock_dream)
      get :new
      assigns[:dream].should equal(@mock_dream)
    end
  end

  describe "GET edit" do
    it "requires a signed in user" do
      controller.should use_before_filter(:authenticate)
    end
    
    it "assigns the requested dream as @dream" do
      @dream_proxy.stubs(:find).with("37", :include => [:appearances]).returns(@mock_dream)
      get :edit, :id => "37"
      assigns[:dream].should equal(@mock_dream)
    end
  end

  describe "POST create" do

    it "requires a signed in user" do
      controller.should use_before_filter(:authenticate)
    end
    
    before(:each) do
      @dream_proxy.stubs(:build).returns(@mock_dream)
    end
    
    describe "with valid params" do
      before(:each) do
        @mock_dream.stubs(:save).returns(true)
        @mock_dream.stubs(:id).returns('1')
      end
      
      it "assigns a newly created dream as @dream" do
        @dream_proxy.stubs(:new).with({'these' => 'params'}).returns(@mock_dream)
        post :create, :dream => {:these => 'params'}
        assigns[:dream].should equal(@mock_dream)
      end

      it "redirects to the created dream" do
        @dream_proxy.stubs(:new).returns(@mock_dream)
        post :create, :dream => {}
        response.should redirect_to(dream_url(@mock_dream))
      end
    end

    describe "with invalid params" do
      before(:each) do
        @mock_dream.stubs(:save).returns(false)
      end
      
      it "assigns a newly created but unsaved dream as @dream" do
        @dream_proxy.stubs(:new).with({'these' => 'params'}).returns(@mock_dream)
        post :create, :dream => {:these => 'params'}
        assigns[:dream].should equal(@mock_dream)
      end

      it "re-renders the 'new' template" do
        @dream_proxy.stubs(:new).returns(@mock_dream)
        post :create, :dream => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    it "requires a signed in user" do
      controller.should use_before_filter(:authenticate)
    end
    
    describe "with valid params" do
      before(:each) do
        @mock_dream.stubs(:update_attributes).returns(true)
        @mock_dream.stubs(:id).returns(1)
      end

      it "updates the requested dream" do
        @dream_proxy.expects(:find).with("37").returns(@mock_dream)
        @mock_dream.expects(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :dream => {:these => 'params'}
      end

      it "assigns the requested dream as @dream" do
        @dream_proxy.stubs(:find).returns(@mock_dream)
        put :update, :id => "1"
        assigns[:dream].should equal(@mock_dream)
      end

      it "redirects to the dream" do
        @dream_proxy.stubs(:find).returns(@mock_dream)
        put :update, :id => "1"
        response.should redirect_to(dream_url(@mock_dream))
      end
    end

    describe "with invalid params" do
      before(:each) do
        @mock_dream.stubs(:update_attributes).returns(false)
      end

      it "updates the requested dream" do
        @dream_proxy.expects(:find).with("37").returns(@mock_dream)
        @mock_dream.expects(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :dream => {:these => 'params'}
      end

      it "assigns the dream as @dream" do
        @dream_proxy.stubs(:find).returns(@mock_dream)
        put :update, :id => "1"
        assigns[:dream].should equal(@mock_dream)
      end

      it "re-renders the 'edit' template" do
        @dream_proxy.stubs(:find).returns(@mock_dream)
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end
  end

  describe "DELETE destroy" do
    before(:each) do
      @mock_dream.stubs(:destroy).returns(true)
    end
    
    it "requires a signed in user" do
      controller.should use_before_filter(:authenticate)
    end
    
    it "destroys the requested dream" do
      @dream_proxy.expects(:find).with("37").returns(@mock_dream)
      @mock_dream.expects(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the dreams list" do
      @dream_proxy.stubs(:find).returns(@mock_dream)
      delete :destroy, :id => "1"
      response.should redirect_to(dreams_url)
    end
  end

end
