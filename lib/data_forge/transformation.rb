module DataForge
  module Transformation

    autoload :Deduplication, 'data_forge/transformation/deduplication'
    autoload :RubyTransformation, 'data_forge/transformation/ruby_transformation'
    autoload :TransformationBase, 'data_forge/transformation/transformation_base'
    autoload :RubyTransformationContext, 'data_forge/transformation/ruby_transformation_context'

  end
end
