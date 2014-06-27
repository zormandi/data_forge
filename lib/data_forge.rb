require 'tmpdir'
require 'csv'

require 'data_forge/version'

module DataForge

  autoload :AttributeDSL, 'data_forge/attribute_dsl'
  autoload :Application, 'data_forge/application'
  autoload :DSL, 'data_forge/dsl'
  autoload :File, 'data_forge/file'
  autoload :Transformation, 'data_forge/transformation'


  class << self

    def application
      @application ||= Application.new
    end

  end
end

self.extend DataForge::DSL
