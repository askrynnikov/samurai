# frozen_string_literal: true
# adds various accessors
module Accessors
  def attr_accessor_with_history(*attrs)
    attrs.each do |attr|
      define_method(attr) do
        instance_eval("@#{attr}.last") if instance_eval("@#{attr}")
      end
      define_method("#{attr}=") do |v|
        unless instance_variable_defined?("@#{attr}")
          instance_eval("@#{attr} = []")
        end
        instance_eval("@#{attr} << v")
      end
      define_method("#{attr}_history") { instance_variable_get("@#{attr}") }
    end
  end

  def strong_attr_accessor(attr, type)
    define_method(attr) do
      instance_variable_get("@#{attr}")
    end
    define_method("#{attr}=") do |v|
      raise TypeError, "value is not #{type}" unless v.is_a?(type)
      instance_variable_set("@#{attr}", v)
    end
  end
end
