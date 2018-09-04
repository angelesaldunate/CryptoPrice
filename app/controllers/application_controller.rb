class ApplicationController < ActionController::Base
  def get_time
    @time = Time.now.strftime("%H:%M:%S ")
    render partial: "date"
  end
end
