class PageController < ApplicationController
  before_action :authenticate_user!

  def confirm_logout
    render "layouts/_confirm_logout"
  end

  def index
    @app_count = App.count
    @message_count = Message.count

    date_range = 30

    start_date = (date_range - 1).days.ago.beginning_of_day
    messages = Message.where("occurred_at >= ?", start_date)

    message_count_errors = []
    message_count_warnings = []
    message_count_info = []

    # Fill in missing dates with zero counts
    labels = []
    (0..date_range-1).each do |i|
      date = (start_date + i.days).to_date
      labels << date.strftime("%Y-%m-%d")

      message_count_errors[i] ||= messages.select { |m| m.level == "error" }.count { |m| m.occurred_at.to_date == date }
      message_count_warnings[i] ||= messages.select { |m| m.level == "warning" }.count { |m| m.occurred_at.to_date == date }
      message_count_info[i] ||= messages.select { |m| m.level == "info" }.count { |m| m.occurred_at.to_date == date }
    end

    @graph_data = {
      labels: labels,
      errors: message_count_errors,
      warnings: message_count_warnings,
      info: message_count_info
    }
  end

  def api_docs
    @key = params[:key]
    @app_url = request.base_url
  end
end
