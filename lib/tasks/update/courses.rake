require_relative "../../../app/models/application_record"
require_relative "../../../app/models/course"

namespace :update do
  desc "Update existing courses from files"
  task :courses => :environment do
    file_path = "lib/assets/courses_" + MOST_RECENT + ".json"
    dataset = File.open(file_path, "r")
    file_size = File.size(file_path)
    progressbar = ProgressBar.create(format:          "%a %b\u{15E7}%i %p%% %t",
                                     progress_mark:   ' ',
                                     remainder_mark:  "\u{FF65}")
    
    dataset.each_line { |line|
      data = JSON.parse(line)
      # Omit the term part of the course code
      course_code = data["code"][0..5]
      title = data["name"] || course_code

      course = Course.where(code: course_code, campus: data["campus"]).first
      unless course.nil?
        course.update(title:        title,
                      department:   data["department"],
                      division:     data["division"],
                      level:        data["level"])
      end

      progressbar.progress += line.size / file_size.to_f * 100
    }

    progressbar.progress = 100
    puts "\nCourses updated"
  end
end