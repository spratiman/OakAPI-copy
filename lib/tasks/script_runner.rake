desc "Runs an external ruby script"
task :update_course => :environment do
    filepath = Rails.root.join('lib', 'assets', 'fetch_course.rb')
	output = `ruby #{filepath}`
	puts output
end