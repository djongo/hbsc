# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require(File.join(File.dirname(__FILE__), 'config', 'boot'))

require 'rake'
require 'rake/testtask'
# require 'rake/rdoctask'
require 'rdoc/task'

require 'tasks/rails'

begin
  gem 'delayed_job', '~>2.0.7'
  require 'delayed/tasks'
rescue LoadError
  STDERR.puts "Run `rake gems:install` to install delayed_job"
end

begin
  gem 'thinking-sphinx', '1.5.0'
  require 'thinking_sphinx/tasks'
rescue LoadError
  puts "You can't load Thinking Sphinx tasks unless the thinking-sphinx gem is installed."
end

require 'flying_sphinx/tasks'
