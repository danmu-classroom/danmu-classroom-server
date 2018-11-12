class Api::LineController < ApiController
  def callback
    service = LineBotService.new(request)
    service.perform
    render plain: 'Success', status: 200
  end
end
