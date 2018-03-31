class RoomsController < ApiController
  before_action :set_room, only: %i[show destroy]

  def index
    @rooms = Room.where(online: true).order(id: :desc)
  end

  def show; end

  def create
    @room = Room.new(room_params)
    @room.creater_ip = request.remote_ip
    @room.stream_ip = request.remote_ip
    if @room.save
      render :show, status: :created, location: @room
    else
      render json: @room.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @room.online = false
    @room.save!
    head :no_content
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end

  def room_params
    # params.require(:room).permit(:stream_ip)
  end
end
