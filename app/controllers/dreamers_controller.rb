class DreamersController < Clearance::UsersController
  def show
    @dreamer = Dreamer.find(params[:id])
  end
end