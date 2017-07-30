namespace :import do
  desc "Import terms from file"
  task :terms => :environment do
    file_path = "lib/assets/courses_" + MOST_RECENT + ".json"
    dataset = File.open(file_path, "r")
    file_size = File.size(file_path)
    progressbar = ProgressBar.create( :format  => "%a %b\u{15E7}%i %p%% %t",
                                      :progress_mark  => ' ',
                                      :remainder_mark => "\u{FF65}")
    
    terms = []
    dataset.each_line { |line|
      data = JSON.parse(line)

      # Map breadth number to appropriate category name
      case data["campus"]
        when "UTSG" then
          breadth_num_to_val = Hash[1 => "Creative and Cultural Representations",
            2 => "Thought, Belief, and Behaviour",
            3 => "Society and Its Institutions",
            4 => "Living Things and Their Environment",
            5 => "The Physical and Mathematical Universes"]

        when "UTSC" then
          breadth_num_to_val = Hash[1 => "Arts, Literature & Language",
            2 => "History, Philosophy & Cultural Studies",
            3 => "Natural Sciences",
            4 => "Social & Behavioural Sciences",
            5 => "Quantitative Reasoning"]
      end

      breadth_string = ""
      data["breadths"].each do |breadth_num|
        breadth_string << breadth_num_to_val[breadth_num] + ";"
      end

      # Grab the course to add terms to it
      course_code = data["code"][0..5]
      course = Course.where(code: course_code, campus: data["campus"]).first!

      terms << Term.new(term:          data["term"],
                        description:   data["description"],
                        prerequisites: data["prerequisites"],
                        exclusions:    data["exclusions"],
                        breadths:      breadth_string,
                        course:        course)

      progressbar.progress += line.size / file_size.to_f * 100
    }

    Term.import terms, on_duplicate_key_ignore: true, validate: true
    progressbar.progress = 100
    puts "\nTerms imported"
  end
end