require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe DreamsController do

  def mock_dream(stubs={})
    @mock_dream ||= mock_model(Dream, stubs)
  end

  describe "GET index" do
    it "assigns all dreams as @dreams" do
      Dream.stub!(:find).with(:all).and_return([mock_dream])
      get :index
      assigns[:dreams].should == [mock_dream]
    end
  end

  describe "GET show" do
    it "assigns the requested dream as @dream" do
      Dream.stub!(:find).with("37").and_return(mock_dream)
      get :show, :id => "37"
      assigns[:dream].should equal(mock_dream)
    end
  end

  describe "GET new" do
    it "assigns a new dream as @dream" do
      Dream.stub!(:new).and_return(mock_dream)
      get :new
      assigns[:dream].should equal(mock_dream)
    end
  end

  describe "GET edit" do
    it "assigns the requested dream as @dream" do
      Dream.stub!(:find).with("37").and_return(mock_dream)
      get :edit, :id => "37"
      assigns[:dream].should equal(mock_dream)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created dream as @dream" do
        Dream.stub!(:new).with({'these' => 'params'}).and_return(mock_dream(:save => true))
        post :create, :dream => {:these => 'params'}
        assigns[:dream].should equal(mock_dream)
      end

      it "redirects to the created dream" do
        Dream.stub!(:new).and_return(mock_dream(:save => true))
        post :create, :dream => {}
        response.should redirect_to(dream_url(mock_dream))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved dream as @dream" do
        Dream.stub!(:new).with({'these' => 'params'}).and_return(mock_dream(:save => false))
        post :create, :dream => {:these => 'params'}
        assigns[:dream].should equal(mock_dream)
      end

      it "re-renders the 'new' template" do
        Dream.stub!(:new).and_return(mock_dream(:save => false))
        post :create, :dream => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested dream" do
        Dream.should_receive(:find).with("37").and_return(mock_dream)
        mock_dream.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :dream => {:these => 'params'}
      end

      it "assigns the requested dream as @dream" do
        Dream.stub!(:find).and_return(mock_dream(:update_attributes => true))
        put :update, :id => "1"
        assigns[:dream].should equal(mock_dream)
      end

      it "redirects to the dream" do
        Dream.stub!(:find).and_return(mock_dream(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(dream_url(mock_dream))
      end
    end

    describe "with invalid params" do
      it "updates the requested dream" do
        Dream.should_receive(:find).with("37").and_return(mock_dream)
        mock_dream.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :dream => {:these => 'params'}
      end

      it "assigns the dream as @dream" do
        Dream.stub!(:find).and_return(mock_dream(:update_attributes => false))
        put :update, :id => "1"
        assigns[:dream].should equal(mock_dream)
      end

      it "re-renders the 'edit' template" do
        Dream.stub!(:find).and_return(mock_dream(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested dream" do
      Dream.should_receive(:find).with("37").and_return(mock_dream)
      mock_dream.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the dreams list" do
      Dream.stub!(:find).and_return(mock_dream(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(dreams_url)
    end
  end

end
