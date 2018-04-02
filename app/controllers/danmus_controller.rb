class DanmusController < ApiController
  before_action :set_room, only: [:create]

  def create
    @danmu = @room.danmus.build(danmu_params)
    sender = Sender.find_by(sender_params)
    if sender.present?
      @danmu.sender = sender
    else
      @danmu.build_sender(sender_params)
    end
    if @danmu.save
      render json: @danmu.to_json, status: :created
    else
      render json: @danmu.errors, status: :unprocessable_entity
    end
  end

  private

  def set_room
    @room = Room.find_by!(key: params[:room_key])
  end

  def danmu_params
    params.require(:danmu).permit(:content)
  end

  def sender_params
    params.require(:danmu)[:sender].permit(:provider, :uid)
  end
end
