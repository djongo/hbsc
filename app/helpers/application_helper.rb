# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  # Method to set focus on item (usually first text field)
  def set_focus_to_id(id)
    javascript_tag("$('#{id}').focus()");
  end

  # Method to make table columns sortable
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  end

end

