module DataForge
  module File
    module CSV
      class CSVRecordFileDefinition

        class << self
          include DataForge::AttributeDSL
        end

        attr_reader :name, :fields
        define_attribute :file_name
        define_attribute :delimiter
        define_attribute :quote
        define_attribute :encoding
        define_attribute :has_header_row

        alias :separator :delimiter



        def initialize(name)
          @name = name
          @file_name = "#{name.to_s}.csv"
          @fields = {}
          @delimiter = ","
          @quote = '"'
          @encoding = "UTF-8"
          @has_header_row = true
        end



        def field(name, type = String)
          @fields[name] = type
        end



        def field_names
          @fields.keys
        end

      end
    end
  end
end
