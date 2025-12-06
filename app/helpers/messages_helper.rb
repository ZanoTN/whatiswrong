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
end
