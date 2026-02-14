module ApplicationHelper
  def current_controller_in_url?(controller_name)
    request.path.include?(controller_name)
  end

  def self.is_demo_version?
    ENV["DEMO_VERSION"] == "true"
  end

  def is_demo_version?
    ApplicationHelper.is_demo_version?
  end

  def format_datetime(datetime)
    ApplicationHelper.format_datetime(datetime)
  end

  def format_date(date)
    ApplicationHelper.format_date(date)
  end

  def format_json(string)
    ApplicationHelper.format_json(string)
  end

  def self.format_datetime(datetime)
    if datetime.nil?
      return ""
    end

    datetime.strftime("%d-%m-%Y %H:%M:%S (%Z)")
  end

  def self.format_date(date)
    if date.nil?
      return ""
    end

    date.strftime("%d %m %Y")
  end

  def self.format_json(string)
    begin
      json_object = JSON.parse(string)
      JSON.pretty_generate(json_object, indent: "  ")
    rescue JSON::ParserError
      "Invalid JSON"
    end
  end
end
