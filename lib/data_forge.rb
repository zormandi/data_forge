require 'csv'

require "data_forge/application"
require "data_forge/attribute_dsl"
require "data_forge/context"
require "data_forge/dsl"
require "data_forge/file_descriptor"
require "data_forge/transform/csv_reader"
require "data_forge/transform/csv_writer"
require "data_forge/transform/file_transformation"
require "data_forge/transform/transformation_context"
require "data_forge/version"

module DataForge
  class << self

    def application
      @application ||= Application.new
    end



    def context
      @context ||= Context.new
    end

  end
end

self.extend DataForge::DSL
