class Api::RoomsController < ApiController
  before_action :set_room, only: %i[show update update_creater]
  before_action :check_auth_token, only: %i[update update_creater]
  before_action :set_user, only: %i[update_creater]

  def index
    @rooms = Room.online.order(id: :desc)
  end

  def show; end

  def create
    @room = Room.new(room_params) do |room|
      room.creater_ip = request.remote_ip
      room.stream_ip = request.remote_ip
    end
    if @room.save
      render :show, status: :created, location: api_room_path(@room), locals: { show_auth_token: true }
    else
      render json: @room.errors, status: :unprocessable_entity
    end
  end

  def update
    if @room.update(room_params)
      render :show, status: :ok, location: api_room_path(@room)
    else
      render json: @room.errors, status: :unprocessable_entity
    end
  end

  def update_creater
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

  def set_user
    @user = User.find_for_authentication(email: login_params[:email])
    render json: { error: 'wrong email or password' }, status: :unauthorized unless @user&.valid_password?(login_params[:password])
  end

  def room_params
    params.require(:room).permit(:webhook)
  end

  def login_params
    params.require(:user).permit(:email, :password)
  end

  def check_auth_token
    render json: { error: 'wrong auth_token' }, status: :unauthorized unless @room.auth?(params[:auth_token])
  end
end
