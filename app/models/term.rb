class Term < ApplicationRecord
  # Associations
  belongs_to :course, inverse_of: :terms
  has_many :ratings, inverse_of: :term
  has_many :lectures, inverse_of: :term
  has_many :enrolments, inverse_of: :term
  has_many :users, through: :enrolments

  def self.update_db(course_id, input)
    case input["campus"]
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
    input["breadths"].each do |breadth_num|
      breadth_string << breadth_num_to_val[breadth_num] + ";"
    end

    # grab the course to add terms to it
    course_code = input["code"][0..5]
    course = Course.where(code: course_code)

    # if the term exists
    if Term.exists?(:course_id => course_id, :term => input["term"])
      # get the term object and update the information
      term = Term.where(course_id: course_id, term: input["term"])
      term.update(description:    input["description"],
                  prerequisites:  input["prerequisites"],
                  exclusions:     input["exclusions"],
                  breadths:       breadth_string)

      term_id = term.as_json[0]["id"]
      # update the lecture sections for each lecture section in the course
      input["meeting_sections"].each do |lecture|
        Lecture.update_db(term_id, course_id, lecture)
      end
    else
      term = Term.new(term:          input["term"],
                      description:   input["description"],
                      prerequisites: input["prerequisites"],
                      exclusions:    input["exclusions"],
                      breadths:      breadth_string,
                      course_id:     course_id)
      term.save!

      # create the lecture section with instructors for every lecture section
      term_id = term.as_json["id"]
      input["meeting_sections"].each do |lecture|
        Lecture.update_db(term_id, course_id, lecture)
      end
    end
  end
end
