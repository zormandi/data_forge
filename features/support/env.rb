require 'aruba'
require 'aruba/in_process'
require 'aruba/cucumber'

require 'data_forge'

Aruba::InProcess.main_class = DataForge::CLI::Main
Aruba.process = Aruba::InProcess
