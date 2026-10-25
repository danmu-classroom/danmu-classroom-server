module ApplicationHelper
  def bootstrap_alerts
    types = { notice: :success, alert: :danger }
    close_btn = tag.button(type: :button, class: "btn-close", 'data-bs-dismiss': :alert, 'aria-label': "Close")
    alerts = flash.map do |type, message|
      style = types.fetch(type.to_sym, "secondary")
      tag.div(safe_join([ message, close_btn ]), class: "alert alert-#{style} alert-dismissible fade show", role: :alert)
    end
    safe_join(alerts, "\n")
  end
end
