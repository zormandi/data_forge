module DataForge
  class FileDescriptor

    attr_reader :name, :fields



    def initialize(name)
      @name = name
      @fields = {}
    end



    def field(name, type)
      @fields[name] = type
    end

  end
end
