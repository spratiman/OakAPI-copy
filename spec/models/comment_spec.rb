require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject { described_class.new(
    body: 'This is a comment with a body.', 
    user: create(:user), course: create(:course)) }

  describe 'Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:course) }
  end
  
  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without body' do
      subject.body = nil
      expect(subject).to_not be_valid
    end
    
    it 'is not valid without course' do
      subject.course = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without user' do
      subject.user = nil
      expect(subject).to_not be_valid
    end
  end
end
