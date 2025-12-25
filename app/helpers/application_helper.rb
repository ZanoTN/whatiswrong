module ApplicationHelper
  def current_controller_in_url?(controller_name)
    request.path.include?(controller_name)
  end

  def format_datetime(datetime)
    if datetime.nil?
      return ""
    end

    datetime.strftime("%d-%m-%Y %H:%M:%S (%Z)")
  end

  def format_date(date)
    if date.nil?
      return ""
    end

    date.strftime("%d %m %Y")
  end

  def format_json(string)
    begin
      json_object = JSON.parse(string)
      JSON.pretty_generate(json_object, indent: '  ')
    rescue JSON::ParserError
      "Invalid JSON"
    end
  end

  def app_version
    Rails.configuration.x.app_version
  end
end
