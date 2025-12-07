module MessagesHelper
  def level_class(message)
    case message.level
    when 'warning'
      'badge bg-orange-lt text-orange-lt-fg text-uppercase'
    when 'error'
      'badge bg-red-lt text-red-lt-fg text-uppercase'
    else
      'badge bg-blue-lt text-blue-lt-fg text-uppercase'
    end
  end

  def card_top_class(message)
    case message.level
    when 'warning'
      'card-status-top bg-warning'
    when 'error'
      'card-status-top bg-danger'
    else
      'card-status-top bg-info'
    end
  end
end
