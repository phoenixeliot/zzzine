module ApplicationHelper
  def body_class
    controller_name + ' ' + [controller_name, action_name].join('-')
  end
end
