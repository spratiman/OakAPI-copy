require 'rails_helper'

RSpec.describe Course, type: :model do
  subject { described_class.new(
    code: 'CSC108', title: 'Introduction to Computer Programming',
    division: 'Faculty of Arts and Science', department: 'Department of Computer Science',
    campus: 'UTSG', level: '100') }

  describe 'Associations' do
    it { should have_many(:terms) }
    it { should have_many(:comments) }
  end
  
  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a code' do
      subject.code = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a title' do
      subject.title = nil
      expect(subject).to_not be_valid
    end
      
    it 'is not valid without a division' do
      subject.division = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a department' do
      subject.department = nil
      expect(subject).to_not be_valid
    end
      
    it 'is not valid without a campus' do
      subject.campus = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a level' do
      subject.level = nil
      expect(subject).to_not be_valid
    end

    it { should validate_uniqueness_of(:code).scoped_to(:campus) }
  end
end
