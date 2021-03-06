ROOT_DIR = File.expand_path(File.dirname(__FILE__)) unless defined? ROOT_DIR

require "rubygems"

begin
  require "vendor/dependencies/lib/dependencies"
rescue LoadError
  begin
    require "vendor/dependencies"
  rescue LoadError
    require ROOT_DIR + "/vendor/dependencies/lib/dependencies" # not sure what's happen up there
  end
end

require "monk/glue"
require "ohm"
require "haml"
require "sass"

require "spawn"
require "faker"
require "mocha"

class Main < Monk::Glue
  set :app_file, __FILE__
  use Rack::Session::Cookie
end

# Connect to redis database.
Ohm.connect(settings(:redis))

# Load all application files.
Dir[root_path("app/**/*.rb")].each do |file|
  require file
end

Dir[root_path("lib/*.rb")].each do |file|
  require file  
end


if defined? Encoding
  Encoding.default_external = Encoding::UTF_8
end

Main.run! if Main.run?
