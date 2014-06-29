require 'data_forge/version'

module DataForge

  autoload :AttributeDSL, 'data_forge/attribute_dsl'
  autoload :CLI, 'data_forge/cli'
  autoload :DSL, 'data_forge/dsl'
  autoload :File, 'data_forge/file'
  autoload :Transformation, 'data_forge/transformation'

end

self.extend DataForge::DSL
