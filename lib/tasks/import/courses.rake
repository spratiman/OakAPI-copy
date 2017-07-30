require 'active_record'
require 'activerecord-import'
require "json"
require "open-uri"
require "yaml"
require 'ruby-progressbar'
require_relative "../../../app/models/application_record"
require_relative "../../../app/models/course"

namespace :import do
  # This is the most recent dataset
  MOST_RECENT = "2c93053"

  desc "Import courses from file"
  task :courses => :environment do
    file_path = "lib/assets/courses_" + MOST_RECENT + ".json"
    dataset = File.open(file_path, "r")
    file_size = File.size(file_path)
    progressbar = ProgressBar.create( :format  => "%a %b\u{15E7}%i %p%% %t",
                                      :progress_mark  => ' ',
                                      :remainder_mark => "\u{FF65}")
    
    courses = []
    dataset.each_line { |line|
      data = JSON.parse(line)
      # Omit the term part of the course code
      course_code = data["code"][0..5]
      title = data["name"] || course_code

      courses << Course.new(
        code: course_code, title: title, department: data["department"], 
        division: data["division"], level: data["level"], 
        campus: data["campus"])

      progressbar.progress += line.size / file_size.to_f * 100
    }

    Course.import courses, on_duplicate_key_ignore: true, validate: true
    progressbar.progress = 100
    puts "\nCourses imported"
  end
end