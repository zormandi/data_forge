module DataForge
  class FileDescriptor

    class << self
      include DataForge::AttributeDSL
    end

    attr_reader :name, :fields
    define_attribute :delimiter
    define_attribute :quote
    define_attribute :escape
    define_attribute :encoding

    alias :separator :delimiter



    def initialize(name)
      @name = name
      @fields = {}
      @delimiter = ","
      @quote = '"'
      @escape = '"'
      @encoding = "UTF-8"
    end



    def field(name, type = String)
      @fields[name] = type
    end



    def field_names
      @fields.keys
    end

  end
end
