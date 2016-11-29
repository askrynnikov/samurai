# frozen_string_literal: true
# adds various accessors
module Accessors
  def attr_accessor_with_history(*methods)
    methods.each do |method|
      raise TypeError 'method name  is not symbol' unless method.is_a?(Symbol)
      define_method(method) { instance_eval("@#{method}.last") }
      define_method("#{method}=") do |v|
        unless instance_variable_defined?("@#{method}")
          instance_eval("@#{method} = []")
        end
        instance_eval("@#{method} << v")
      end
      define_method("#{method}_history") { instance_variable_get("@#{method}") }
    end
  end

  def strong_attr_accessor(method, type)
    raise TypeError 'method name  is not symbol' unless method.is_a?(Symbol)
    define_method(method) do
      instance_variable_get("@#{method}")
    end
    define_method("#{method}=") do |v|
      raise TypeError "value is not #{type}" unless v.is_a?(type)
      instance_variable_set("@#{method}", v)
    end
  end
end
