# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: "Test User", github_username: "testuser") }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).not_to be_valid
      expect(subject.errors[:name]).to include("não pode estar em branco")
    end

    it 'is not valid without a github_username' do
      subject.github_username = nil
      expect(subject).not_to be_valid
      expect(subject.errors[:github_username]).to include("não pode estar em branco")
    end
  end

  describe '.ransackable_attributes' do
    it 'returns an array of ransackable attributes' do
      expect(User.ransackable_attributes).to include("name", "github_username", "followers")
    end
  end
end
