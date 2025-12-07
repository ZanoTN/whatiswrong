class PageController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @app_count = App.count
    @message_count = Message.count


    date_range = 30

    start_date = date_range.days.ago.beginning_of_day
    messages = Message.where('occurred_at >= ?', start_date)


    message_count_errors = []
    message_count_warnings = []
    message_count_others = []

    # Fill in missing dates with zero counts
    labels = []
    (0..date_range-1).each do |i|
      date = (start_date + i.days).to_date
      labels << date.strftime("%Y-%m-%d")

      message_count_errors[i] ||= messages.select { |m| m.level == 'error' }.count { |m| m.occurred_at.to_date == date }
      message_count_warnings[i] ||= messages.select { |m| m.level == 'warning' }.count { |m| m.occurred_at.to_date == date }
      message_count_others[i] ||= messages.select { |m| !['error', 'warning'].include?(m.level) }.count { |m| m.occurred_at.to_date == date }
    end

    @graph_data = {
      labels: labels,
      errors: message_count_errors,
      warnings: message_count_warnings,
      others: message_count_others
    }
  end

  def toggle_theme
    if cookies[:theme] == 'dark'
      cookies[:theme] = { value: 'light', expires: 1.year.from_now }
    else
      cookies[:theme] = { value: 'dark', expires: 1.year.from_now }
    end

    redirect_back(fallback_location: root_path)
  end
end
