require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RatingsController do
  
  before(:each) do
    @proxy = stub_everything('rating proxy')
    @dreamer = Dreamer.mock(:id => '1', :ratings => @proxy)
    
    Dreamer.stubs(:find).with('1').returns(@dreamer)
    @dream = Dream.mock(:id => '1')
    @rating = Rating.mock(:dream => @dream)
  end

  describe "GET index" do
    it "assigns highest rated dreams as @dreams" do
      Dream.expects(:find).with(:all, {:limit => 15, :offset => 0, :order => ['average_rating DESC']}).returns([@dream])
      get :index
      assigns[:dreams].should == [@dream]
    end
  end

  describe "POST create" do

    before(:each) do
      login_as :quentin
      @current_user.stubs(:ratings).returns(@proxy)
      @proxy.stubs(:find_or_initialize_by_dream_id).returns(@rating)
    end
    
    describe "with valid params" do
      before(:each) do
        @rating.stubs(:save).returns(true)
      end
      
      it "assigns a newly created rating as @rating" do
        @proxy.expects(:find_or_initialize_by_dream_id).with({'these' => 'params'}).returns(@rating)
        post :create, :dreamer_id => '1', :rating => {:these => 'params'}
        assigns[:rating].should equal(@rating)
      end

      it "redirects to the associated dream" do
        post :create, :dreamer_id => '1', :rating => {}
        response.should redirect_to(dream_url(@rating.dream))
      end
    end

    describe "with invalid params" do
      before(:each) do
        @rating.stubs(:save).returns(false)
      end
      
      it "assigns a newly created but unsaved rating as @rating" do
        @proxy.expects(:find_or_initialize_by_dream_id).with({'these' => 'params'}).returns(@rating)
        post :create, :dreamer_id => '1', :rating => {:these => 'params'}
        assigns[:rating].should equal(@rating)
      end

      it "re-renders the 'new' template" do
        post :create, :dreamer_id => '1', :rating => {}
        response.should render_template('new')
      end
    end

  end

end
