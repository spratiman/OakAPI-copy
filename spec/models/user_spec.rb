require 'rails_helper'

RSpec.describe User, type: :model do
  subject { described_class.new(
    email: 'test@example.com', password: 'valid_password',
    name: 'John Smith', nickname: 'John') }

  describe 'Associations' do
    it { should have_many(:terms) }
    it { should have_many(:comments) }
    it { should have_many(:ratings) }
  end

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without an email' do
      subject.email = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a password' do
      subject.password = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a nickname' do
      subject.nickname = nil
      expect(subject).to_not be_valid
    end
  end
end
