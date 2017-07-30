require "active_record"
require "json"
require "open-uri"
require "yaml"
require 'ruby-progressbar'
require_relative "../../../app/models/application_record"
require_relative "../../../app/models/course"

namespace :download do
  desc "Downloads courses from Cobalt datasets and stores in assets folder"
  task :courses => :environment do
    # Dataset hashes corresponding to different terms
    DATASETS = ["2c93053", "1524e41", "7bd4ddb", "f960682", "42a0725", "faf8f1f"]

    # Retrieve courses directly from dataset available by the name courses.json
    # File can be obtained on https://github.com/cobalt-uoft/datasets

    # start downloading the course data for each dataset stored online
    puts "Downloading courses data..."
    DATASETS.each{ |dataset|
      total_size = 0
      page_content = open("https://github.com/cobalt-uoft/datasets/raw/" + dataset + "/courses.json",
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
      File.open("lib/assets/courses_" + dataset + ".json", "w+") do |f|
        f.write(page_content.read)
      end
    }
    puts "Data downloaded and stored in file"
  end
end
