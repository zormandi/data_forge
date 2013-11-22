module DataForge
  class FileDescriptor

    attr_reader :name, :fields



    def initialize(name)
      @name = name
      @fields = {}
    end



    def field(name, type = String)
      @fields[name] = type
    end



    def field_names
      @fields.keys
    end

  end
end
