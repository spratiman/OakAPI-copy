require "json"
require "open-uri"
require "active_record"
require_relative "../../app/models/application_record"
require_relative "../../app/models/course"
require "yaml"

dbconf = YAML.load_file(File.join(__dir__, "/../../config", "database.yml"))

ActiveRecord::Base.establish_connection(
  dbconf["development"]
)
# Retrieve courses directly from dataset available by the name courses.json
# File can be obtained on https://github.com/cobalt-uoft/datasets
puts "Downloading courses data..."
total_size = 0
page_content = open("https://github.com/cobalt-uoft/datasets/raw/master/courses.json",
  :content_length_proc => lambda {|t|
    if t && 0 < t
      puts "Total size to be downloaded: " + t.to_s
      total_size = t
    end
  },
  :progress_proc => lambda {|p|
    print "%.1f%% downloaded" % (p/(total_size*1.0) * 100)
    print "\r"
  })


puts "Data downloaded, start processing..."
progress = 0
page_content.each_line { |line|
  course = JSON.parse(line)
  Course.update_db(course)
  progress += line.size
  print "%.1f%% done" % (progress/(total_size * 1.0) * 10)
  print "\r"
}
puts "Done processing"
