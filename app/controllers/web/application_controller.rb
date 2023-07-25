# frozen_string_literal: true

module Web
  class ApplicationController < ApplicationController
    helper_method %i[table_column_visible?]

    def table_column_visible?(column, controller = controller_name)
      instance_variable_get("@#{controller.classify.underscore}_columns").include?(column)
    end
  end
end
