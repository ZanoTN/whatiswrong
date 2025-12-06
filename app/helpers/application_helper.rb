module ApplicationHelper
  def current_controller_in_url?(controller_name)
    request.path.include?(controller_name)
  end
end
