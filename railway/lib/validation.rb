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
    rescue TypeError
      false
    end

    def validate!
      context = self.class
      while (checks = context.class_eval('@checks'))
        checks.each do |check|
          variable = instance_variable_get("@#{check[:attribute]}")
          checking(variable, check[:type], check[:option])
        end
        context = context.superclass
      end
    end

    def checking(attr, type, option)
      case type
      when :presence
        presence_checking(attr)
      when :format
        format_checking(attr, option)
      when :type
        type_checking(attr, option)
      else
        raise TypeError 'Incorrect type of check'
      end
    end

    def presence_checking(attr)
      raise TypeError 'attr is nil' if attr.nil?
      raise TypeError 'attr is empty string' if attr == ''
    end

    def format_checking(attr, format)
      raise TypeError 'attr does not match the format' unless attr =~ format
    end

    def type_checking(attr, type)
      raise TypeError 'attr has the wrong type' unless attr.is_a?(type)
    end
  end
end
