require 'resque/scheduler'
require 'resque/scheduler/server'
Dir["#{Rails.root}/app/jobs/*.rb"].each { |file| require file }