# frozen_string_literal: true

module ApplicationHelper
  def action_to_css_class_color(name = action_name)
    name = name.dup.downcase.to_s unless action_name == name
    if %w[new edit update create].include?(name)
      'success'
    elsif %w[show index].include?(name)
      'primary'
    elsif name == 'destroy'
      'warning'
    else
      'default'
    end
  end

  def datetime_humanized(datetime)
    datetime.strftime('%e %B %Y, %H:%M')
  end
end
