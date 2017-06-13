require "active_record"
require "json"
require "open-uri"
require "yaml"
require 'ruby-progressbar'
require_relative "../../app/models/application_record"
require_relative "../../app/models/course"

namespace :app do

  desc "Downloads courses from Cobalt datasets and stores in assets folder"
  task :download_courses => :environment do
    # Retrieve courses directly from dataset available by the name courses.json
    # File can be obtained on https://github.com/cobalt-uoft/datasets
    puts "Downloading courses data..."
    total_size = 0
    page_content = open("https://github.com/cobalt-uoft/datasets/raw/master/courses.json",
      :content_length_proc => lambda {|t|
        if t && 0 < t
          puts "Bytes downloaded:"
        end
      },
      :progress_proc => lambda {|p|
        print p
        print "\r"
        total_size = p
      })
    puts total_size
    # Write the course data to a file
    File.open("lib/assets/courses.json", "w+") do |f|
      f.write(page_content.read)
    end
    puts "Data downloaded and stored in file"
  end

  desc "Creates/updates courses using courses loaded from file"
  task :update_courses => :environment do
    file_path = "lib/assets/courses.json"
    page_content = File.open(file_path, "r")
    file_size = File.size(file_path)

    progressbar = ProgressBar.create( :format         => "%a %b\u{15E7}%i %p%% %t",
                        :progress_mark  => ' ',
                        :remainder_mark => "\u{FF65}")
    progress = 0
    page_content.each_line { |line|
      course = JSON.parse(line)
      Course.update_db(course)
      progress += line.size
      progressbar.progress = (progress/(file_size * 1.0) * 100)
    }
    puts "\nCourses updated"
  end

end

