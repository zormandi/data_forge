require 'fileutils'

working_directory = File.absolute_path File.join(File.dirname(__FILE__), "..", "..", "tmp")

Before do
  FileUtils.rm_rf working_directory
  FileUtils.mkdir_p working_directory
  Dir.chdir working_directory
end

World do
  DataForgeWorld.new working_directory
end
