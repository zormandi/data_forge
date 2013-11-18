require "data_forge/application"
require "data_forge/context"
require "data_forge/dsl"
require "data_forge/file_descriptor"
require "data_forge/transform/data_transformer"
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
