require 'data_forge/version'

module DataForge

  autoload :CLI, 'data_forge/cli'
  autoload :DSL, 'data_forge/dsl'
  autoload :File, 'data_forge/file'
  autoload :Shell, 'data_forge/shell'
  autoload :Transformation, 'data_forge/transformation'
  autoload :ValidOptions, 'data_forge/valid_options'

end

self.extend DataForge::DSL::Commands,
            DataForge::DSL::Helpers
