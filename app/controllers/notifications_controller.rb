class NotificationsController < ApplicationController

  def index
    # Fetch the data you need and render the HTML
    # Replace this with the logic you use to generate the notifications HTML
    render plain: render_to_string(partial: "notifications/notifications_partial", locals: { wines: current_user.wines })
  end

end
