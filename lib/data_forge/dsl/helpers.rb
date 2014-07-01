module DataForge
  module DSL
    module Helpers

    end
  end
end



def Object.const_missing(name)
  case name
    when :COMMAND_SCRIPT
      DataForge::CLI.command_script

    when :PARAMS
      DataForge::CLI.user_params

    else
      raise NameError, "uninitialized constant #{name}"
  end
end
