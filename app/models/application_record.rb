# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def self.validator_find(column_name, validator_name)
    _validators[column_name].find { _1.kind == validator_name }
  end
end
