require 'resque/server'

#namespace :resque do
 #  	task :setup do
 #    	require 'resque'
 #    	# you probably already have this somewhere
 #    	Resque.redis = 'localhost:6379'
	# end

	# task 'resque:setup' => :environment

	# task "resque:setup" do
 #  		ENV['QUEUE'] = '*'
	# end
#end
task "resque:setup" => :environment do
  ENV['QUEUE'] ||= '*'
  #for redistogo on heroku http://stackoverflow.com/questions/2611747/rails-resque-workers-fail-with-pgerror-server-closed-the-connection-unexpectedl
  Resque.before_fork = Proc.new { ActiveRecord::Base.establish_connection }
end