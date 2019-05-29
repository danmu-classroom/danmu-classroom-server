class Api::DanmusController < ApiController
  before_action :set_room, only: %i[index create]
  before_action :check_auth_token, only: %i[index]

  def index
    render json: @room.pop_danmus, status: :ok
  end

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

  def check_auth_token
    render json: { error: 'wrong auth_token' }, status: :unauthorized unless @room.auth?(params[:auth_token])
  end

  def danmu_params
    params.require(:danmu).permit(:content)
  end

  def sender_params
    params.require(:danmu)[:sender].permit(:provider, :uid)
  end
end
