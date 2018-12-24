# frozen_string_literal: true

module ApplicationHelper
  def display_errors(field, error_entity)
    if error_entity.is_a?(String)
      error_entity
    elsif error_entity.is_a?(Array)
      "#{field.to_s.humanize} #{error_entity.join(', ')}."
    else
      raise ArgumentError, 'Cannot process anything but Array or String.'
    end
  end
end
