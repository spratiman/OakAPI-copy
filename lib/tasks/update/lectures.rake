namespace :update do
  desc "Update lectures from file"
  task :lectures => :environment do
    file_path = "lib/assets/courses_" + MOST_RECENT + ".json"
    dataset = File.open(file_path, "r")
    file_size = File.size(file_path)
    progressbar = ProgressBar.create( :format  => "%a %b\u{15E7}%i %p%% %t",
                                      :progress_mark  => ' ',
                                      :remainder_mark => "\u{FF65}")
    
    dataset.each_line { |line|
      data = JSON.parse(line)

      # Grab the course to add terms to it
      course_code = data["code"][0..5]
      course = Course.where(code: course_code, campus: data["campus"]).first!
      term = Term.where(term: data["term"], course: course).first!

      data["meeting_sections"].each do |meeting_section|
        lecture = Lecture.where(term: term, code: meeting_section["code"]).first
        
        # parse the instructors into a string
        instructors = ""
        meeting_section["instructors"].each do |instructor|
          instructors << instructor + ";"
        end

        # Update the lecture if it exists
        lecture.update(instructor: instructors) unless lecture.nil?
      end

      progressbar.progress += line.size / file_size.to_f * 100
    }

    progressbar.progress = 100
    puts "\nLectures updated"
  end
end
