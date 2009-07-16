class InvitationsController < ApplicationController
  
  before_filter :authenticate
  before_filter :restrict_to_admin
  
  # GET /invitations
  # GET /invitations.xml
  def index
    @invitations = Invitation.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @invitations }
    end
  end

  # GET /invitations/new
  # GET /invitations/new.xml
  def new
    @invitation = Invitation.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @invitation }
    end
  end

  # POST /invitations
  # POST /invitations.xml
  def create
    @invitation = Invitation.new(params[:invitation])
    if @invitation.save
      UserMailer.deliver_invitation(@invitation)
      flash[:notice] = 'Invitation was successfully created.'
      redirect_to invitations_url
    else
      render :action => "new"
    end
  end
end
