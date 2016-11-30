# frozen_string_literal: true
# check the contents of the object
module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  # stores checks in the array
  module ClassMethods
    def validate(attribute, type, option = nil)
      @checks ||= []
      @checks << { attribute: attribute, type: type, option: option }
    end
  end

  # called checks
  module InstanceMethods
    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    def validate!
      context = self.class
      while context != Object
        if checks = context.class_eval('@checks')
          checks.each do |check|
            variable = instance_variable_get("@#{check[:attribute]}")
            method_checking = "#{check[:type]}_checking"
            send method_checking, variable, check[:option] if check[:option]
          end
        end
        context = context.superclass
      end
    end

    def presence_checking(attr)
      raise TypeError.new('attr is nil') if attr.nil?
      raise TypeError.new('attr is empty string') if attr == ''
    end

    def format_checking(attr, format)
      raise TypeError.new('attr does not match the format') unless attr =~ format
    end

    def type_checking(attr, type)
      raise TypeError.new('attr has the wrong type') unless attr.is_a?(type)
    end
  end
end
