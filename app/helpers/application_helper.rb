# frozen_string_literal: true

module ApplicationHelper
  def display_errors(field, errors)
    if errors.is_a?(String)
      errors
    else
      errors.map { |error| "#{field.to_s.humanize} #{error}."}.join(" ")
    end
  end
end
