class Lecture < ApplicationRecord
  # Associations
  belongs_to :term, inverse_of: :lectures

  def self.update_db(term_id, course_id, input)
    # parse the instructors into a string
    instructors = ""
    input["instructors"].each do |instructor|
      instructors << instructor + ";"
    end

    # grab the term to add lectures to it
    term = Term.where(id: term_id, course_id: course_id)

    # if the lecture exists
    if Lecture.exists?(:term_id => term_id, :code => input["code"])
      # get the lecture object and update the information
      lecture = Lecture.where(term_id: term_id, code: input["code"])
      lecture.update(instructor: instructors)
    else
      # no lecture exists therefore we make a new one
      lecture = Lecture.new(code:        input["code"],
                            instructor: instructors,
                            term_id: term_id)
      lecture.save!
    end
  end
end
