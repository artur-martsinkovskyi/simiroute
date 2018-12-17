# frozen_string_literal: true

module ApplicationHelper
  def display_errors(field, errors)
    if errors.is_a?(String)
      "#{field.to_s.humanize} #{errors}."
    else
      errors.map { |error| display_errors(field, error) }.join(' ')
    end
  end
end
