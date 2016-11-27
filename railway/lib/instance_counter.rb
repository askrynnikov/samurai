# frozen_string_literal: true
# Instance counter for all objects
module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  # stores objects in the array
  module ClassMethods
    attr_reader :instances

    alias all instances

    def number_instances
      @instances.size
    end

    # private
    def add_instance(object)
      @instances ||= []
      @instances << object
      # self.superclass.add_instance(object)
    end
  end

  # called when an object is created
  module InstanceMethods
    # protected
    def register_instance
      self.class.send :add_instance, self
    end
  end
end
