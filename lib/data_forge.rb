require 'tmpdir'
require 'csv'

require "data_forge/application"
# require 'data_forge/attribute_dsl'
require "data_forge/dsl"
require "data_forge/version"

module DataForge

  autoload :AttributeDSL, 'data_forge/attribute_dsl'
  autoload :File, 'data_forge/file'
  autoload :Transformation, 'data_forge/transformation'


  class << self

    def application
      @application ||= Application.new
    end

  end
end

self.extend DataForge::DSL
