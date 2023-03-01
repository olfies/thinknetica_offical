module InstanceCounter
  attr_reader :instances

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def instances
      @instances ||= 0
    end

    private

    def instances_count
      @instances = instances + 1
    end
  end

  module InstanceMethods
    def register_instance
      self.class.send(:instances_count)
    end
  end
end
