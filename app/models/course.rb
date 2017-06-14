class Course < ApplicationRecord
  # Validations
  validates :code, uniqueness: true, presence: true
  validates :title, presence: true

  # Associations
  has_many :terms, inverse_of: :course
  has_many :comments, inverse_of: :course

  def self.update_db(input)
    # parse the course code not include the term
    course_code = input["code"][0..5]

    # parse the title of the course
    if input["name"].to_s.empty?
      title = course_code
    else
      title = input["name"]
    end

    if Course.exists?(:code => course_code)
      course = Course.where(code: course_code)
      course.update(title:        title,
                    department:   input["department"],
                    division:     input["division"],
                    level:        input["level"],
                    campus:       input["campus"])

      course_id = course.as_json[0]["id"]
      Term.update_db(course_id, input)
    else
      course = Course.new(code:       course_code,
                          title:      title,
                          department: input["department"],
                          division:   input["division"],
                          level:      input["level"],
                          campus:     input["campus"])
      course.save!

      course_id = course.as_json["id"]
      Term.update_db(course_id, input)
    end
  end
end
