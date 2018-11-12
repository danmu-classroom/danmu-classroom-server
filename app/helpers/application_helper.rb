module ApplicationHelper
  def bootstrap_alerts
    types = { notice: :success, alert: :danger }
    cloes_btn = content_tag(:button, 'x', class: :close, 'data-dismiss': :alert)
    alerts = flash.map do |type, message|
      content = cloes_btn + message
      style = types.fetch(type.to_sym, 'secondary')
      klass = "alert alert-#{style} alert-dismissable"
      content_tag(:div, content, class: klass)
    end
    alerts.join("\n").html_safe
  end
end
