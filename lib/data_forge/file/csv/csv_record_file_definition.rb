module DataForge
  module File
    module CSV
      class CSVRecordFileDefinition

        class << self
          include DataForge::DSL::Attributes
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



        def without_field(name)
          @fields.delete name
        end



        def field_names
          @fields.keys
        end



        def copy(definition)
          delimiter definition.delimiter
          quote definition.quote
          encoding definition.encoding
          has_header_row definition.has_header_row

          definition.fields.each { |name, type| field name, type }
        end

      end
    end
  end
end
