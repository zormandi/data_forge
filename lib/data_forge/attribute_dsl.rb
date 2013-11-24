module DataForge
  module AttributeDSL

    def define_attribute(name)
      define_method name do |*args|
        return instance_variable_get "@#{name}" if args.count.zero?

        instance_variable_set "@#{name}", args.first
      end
    end

  end
end
