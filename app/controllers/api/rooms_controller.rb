class Api::RoomsController < ApiController
  before_action :set_room, only: %i[show update]
  before_action :check_auth_token, only: %i[update]
  before_action :set_user, only: %i[update]

  def index
    @rooms = Room.online.order(id: :desc)
  end

  def show; end

  def create
    @room = Room.new
    @room.creater_ip = request.remote_ip
    if @room.save
      render :show, status: :created, location: api_room_path(@room), locals: { show_auth_token: true }
    else
      render json: @room.errors, status: :unprocessable_entity
    end
  end

  def update
    @room.creater = @user
    if @room.save
      render :show, status: :ok, location: api_room_path(@room)
    else
      render json: @room.errors, status: :unprocessable_entity
    end
  end

  private

  def set_room
    @room = Room.find_by!(key: params[:key])
  end

  def check_auth_token
    render json: { error: 'wrong auth_token' }, status: :unauthorized unless @room.auth?(params[:auth_token])
  end

  def set_user
    @user = User.find_for_authentication(email: params[:email])
    render json: { error: 'wrong email or password' }, status: :unauthorized unless @user&.valid_password?(params[:password])
  end
end
