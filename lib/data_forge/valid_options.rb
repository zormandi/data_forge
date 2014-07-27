module DataForge
  class ValidOptions

    def initialize(command_name, defaults)
      @command_name, @options = command_name, defaults
    end



    def import(options)
      validate options
      @options.merge! options
    end



    def [](key)
      raise "Missing :#{key} directive for `#{@command_name}` command" if @options[key].nil?
      @options[key]
    end



    private

    def validate(options)
      unknown_options = options.keys - @options.keys
      raise "Unknown directive :#{unknown_options.first} specified for `#{@command_name}` command" unless unknown_options.empty?
    end

  end
end
