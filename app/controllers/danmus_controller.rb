class DanmusController < ApiController
  def index
    @room = current_user.rooms.find(params[:room_id])
    @danmus = @room.danmus
  end
end
