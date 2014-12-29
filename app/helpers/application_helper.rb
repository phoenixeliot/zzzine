module ApplicationHelper
  def body_class
    classes = controller_name + ' ' + [controller_name, action_name].join('-')
    if current_user
      classes += ' logged-in'
    end
    return classes
  end
end
