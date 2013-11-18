require "data_forge/application"
require "data_forge/version"

module DataForge
  def self.application
    @application ||= Application.new
  end
end
