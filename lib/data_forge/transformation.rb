module DataForge
  module Transformation

    autoload :Deduplication, 'data_forge/transformation/deduplication'
    autoload :Filter, 'data_forge/transformation/filter'
    autoload :RubyTransformation, 'data_forge/transformation/ruby_transformation'
    autoload :RubyTransformationContext, 'data_forge/transformation/ruby_transformation_context'
    autoload :TransformationBase, 'data_forge/transformation/transformation_base'

  end
end
