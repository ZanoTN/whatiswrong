class PageController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @app_count = App.count
    @message_count = Message.count


    date_range = 30

    start_date = date_range.days.ago.beginning_of_day
    messages = Message.where('created_at >= ?', start_date)
    message_count_errors = messages.where(level: 'error').group("DATE(created_at)").count
    message_count_warnings = messages.where(level: 'warning').group("DATE(created_at)").count
    message_count_others = messages.where.not(level: ['error', 'warning']).group("DATE(created_at)").count

    # Fill in missing dates with zero counts
    labels = []
    (0..date_range-1).each do |i|
      date = (start_date + i.days).to_date
      labels << date.strftime("%Y-%m-%d")
      message_count_errors[date] ||= 0
      message_count_warnings[date] ||= 0
      message_count_others[date] ||= 0
    end



    @graph_data = {
      labels: labels,
      errors: message_count_errors.map { |_, count| count },
      warnings: message_count_warnings.map { |_, count| count },
      others: message_count_others.map { |_, count| count }
    }

    Rails.logger.info("Graph Data: #{@graph_data.inspect}")

  end
end
